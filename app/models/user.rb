class User < ActiveRecord::Base

  # Similar to a "Followings table"
  has_many :tips_received, class_name: "TweetTip", foreign_key: "recipient_id"
  has_many :tips_given, class_name: "TweetTip", foreign_key: "sender_id"

  has_many :addresses

  validates :screen_name, uniqueness: { case_sensitive: false }, presence: true

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
    user = User.find_by("screen_name ILIKE ?", "%#{screen_name}%")
    return if user.blank?
    return if user.addresses.blank?
    return user
  end

  def self.create_profile(screen_name, uid: nil, via_oauth: false)
    result = TipperClient.search_user(screen_name) unless via_oauth

    user = User.find_or_create_by(screen_name: screen_name)
    user.authenticated = via_oauth
    user.uid = uid

    user.addresses.create(BitcoinAPI.generate_address)
    return user
  end

end
