namespace :twitter do

  desc "Everything"
  task :listen_to_mentions => :environment do

    p "listen_to_mentions ..."
    TWITTER_STREAM.user(replies: "all") do |object|
      p object
      case object
      when Twitter::Tweet
        # TweetHandler.new(object.text, object.user.screen_name)
        ap object.attrs
      when Twitter::DirectMessage
        ap "DM Received"
        ap "Do nothing ..."
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
      else
        ap "Another Object Type Returned"
      end

      # TODO: Handle HTTP 420 error code
      # Means there's too many connections
      # rescue?

    end
  end

  task :listen_to_hashtag => :environment do

    p "listen_to_hashtag ..."

    TWITTER_STREAM.filter(track: "#tippercoin") do |object|
      p object
      case object
      when Twitter::Tweet
        # TweetHandler.new(object.text)
        ap object.attrs
      when Twitter::DirectMessage
        ap "DM Received"
        ap "Do nothing ..."
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
      else
        ap "Another Object Type Returned"
      end

      # TODO: Handle HTTP 420 error code
      # Means there's too many connections
      # rescue?

    end
  end

end
