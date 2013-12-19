namespace :twitter do

  desc "Everything"
  task :listen => :environment do

    p "listening to Twitter Streaming API ..."
    TWITTER_STREAM.user(replies: "all", track: "#tippercoin") do |object|
      Thread.new do

        p object
        case object
        when Twitter::Tweet
          ap "\"#{object.text}\" - #{object.user.screen_name}"

          Tweet::Runner.execute(
            tweet: object.text,
            screen_name: object.user.screen_name,
            status_id: object.id)

        when Twitter::DirectMessage
          ap "DM Received"
        when Twitter::Streaming::StallWarning
          warn "Falling behind!"
        else
          # TODO: Handle HTTP 420 error code
          # Means there's too many connections
          # rescue?
        end

      end
    end
  end

end
