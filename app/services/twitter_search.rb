class TwitterSearch

  attr_reader :screen_name, :name, :description, :avatar_large, :avatar_small,
  :api_user_id_str

  def initialize(screen_name)

    user = TWITTER_CLIENT.user(screen_name)

    @screen_name = user.screen_name
    @name = user.name
    @description = user.description
    @avatar_large = user.profile_image_url_https.to_s.gsub("_normal", "")
    @avatar_small = user.profile_image_url_https.to_s
    @api_user_id_str = user.id.to_s
  end

end
