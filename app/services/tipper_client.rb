module TipperClient
  extend self

  def search_user(screen_name)
    user = TWITTER_CLIENT.user(screen_name)

    {
      screen_name: user.screen_name,
      name: user.name,
      description: user.description,
      avatar_large: user.profile_image_url_https.to_s.gsub("_normal", ""),
      avatar_small: user.profile_image_url_https.to_s,
      api_user_id_str: user.id.to_s
    }
  end

  # Returns: Array of tweets
  def mentions
    TWITTER_CLIENT.mentions(count: 200).map do |mention|
      mention.attrs
    end
  end

  # Returns: Array of tweets
  def hashtags
    TWITTER_CLIENT.search("#tippercoin").attrs[:statuses]
  end

  def uncaught_mentions
    uncaught = []
    tweets = mentions + hashtags

    tweets.each do |tweet|
      tt = TweetTip.where(api_tweet_id_str: tweet[:id].to_s).first
      uncaught << tweet if tt.blank?
    end

    uncaught.map do |tweet|
      {
        content: tweet[:text],
        screen_name: tweet[:user][:screen_name],
        api_tweet_id_str: tweet[:id].to_s
      }
    end

  end

  def save_uncaught_mentions
    uncaught_mentions.each do |tweet|
      TweetTip.create(tweet)
    end
  end

  def delete_all_statuses
    TWITTER_CLIENT.home_timeline.each do |t|
      TWITTER_CLIENT.destroy_status(t.id)
    end
  end

end
