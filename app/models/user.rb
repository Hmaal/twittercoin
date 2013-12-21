class User < ActiveRecord::Base

  # Similar to a "Followings table"
  has_many :tips_received, class_name: "TweetTip", foreign_key: "recipient_id"
  has_many :tips_given, class_name: "TweetTip", foreign_key: "sender_id"

  has_many :addresses

  validates :screen_name, uniqueness: { case_sensitive: false }, presence: true
  validates :api_user_id_str, uniqueness: true, presence: true


  def all_tips
    self.tips_received + self.tips_given
  end

  # TODO
  def balance
    BitcoinAPI.get_balance(user.addresses.first.public_key)
  end

  # TODO: mock this
  def enough_balance?
    return true
  end

  def self.find_profile(screen_name)
    user = User.where("screen_name ILIKE ?", "%#{screen_name}%").first
    return if user.blank?
    return if user.addresses.blank?
    return user
  end

  # TODO: Twitter Auth
  def self.create_profile(screen_name, authenticated: true)
    user = User.find_or_create_by(screen_name: screen_name)
    result = TipperClient.search_user(screen_name)

    user.screen_name = result[:screen_name]
    user.authenticated = authenticated
    user.api_user_id_str = result[:api_user_id_str]
    user.save

    user.addresses.create(BitcoinAPI.generate_address)
    return user
  end

end
