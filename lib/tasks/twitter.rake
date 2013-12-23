require 'dotenv/tasks'

namespace :twitter do

  desc "Everything"
  task :listen => :environment do

    p "listening to Twitter Streaming API ..."
    TWITTER_STREAM.user(replies: "all", track: "#tippercoin") do |object|
      Thread.new do
        begin
          p object

          case object
          when Twitter::Tweet
            ap "TWEET: #{object.text}"
            ap "SENDER: @#{object.user.screen_name}"

            Tweet::Runner.execute(
              content: object.text,
              sender: object.user.screen_name,
              status_id: object.id)

          when Twitter::DirectMessage
            ap "DM Received"
          when Twitter::Streaming::StallWarning
            ap "Falling behind!"
            # TODO: PagerDuty
          else
            # TODO: Handle HTTP 420 error code
            # Means there's too many connections
            # rescue?
          end
        rescue => e
          puts e.inspect
          puts e.backtrace

          # TODO: Automated response, e.g. 'something went wrong'
          # @reply = Tweet::Message::Invalid.send(@state, @sender)
          # TWITTER_CLIENT.update(@reply, in_reply_to_status_id: @reply_id)

          raise CriticalError.new("Error in twitter stream: #{e.inspect}", {
            inspect: e.inspect,
            backtrace: e.backtrace
            })
        ensure
          begin
            if (ActiveRecord::Base.connection && ActiveRecord::Base.connection.active?)
              ap "Closing ActiveRecord Connection"
              ActiveRecord::Base.connection.close
            end
          rescue => e
            raise CriticalError.new("ActiveRecord Connection did not close: #{e.inspect}", {
              inspect: e.inspect,
              backtrace: e.backtrace
            })
          end
        end

      end
    end
  end

end
