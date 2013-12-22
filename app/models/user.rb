class User < ActiveRecord::Base

  # Similar to a "Followings table"
  has_many :tips_received, class_name: "TweetTip", foreign_key: "recipient_id"
  has_many :tips_given, class_name: "TweetTip", foreign_key: "sender_id"

  has_many :addresses

  validates :screen_name, uniqueness: { case_sensitive: false }, presence: true

  def all_tips
    (self.tips_received.valid + self.tips_given.valid).sort_by { |t| t.created_at }.reverse
  end

  def self.find_profile(screen_name)
    user = User.find_by("screen_name ILIKE ?", "%#{screen_name}%")
    return if user.blank?
    return if user.addresses.blank?
    return user
  end

  def self.create_profile(screen_name)
    user = User.find_or_create_by(screen_name: screen_name)
    user.slug ||= SecureRandom.hex(8)

    user.save

    user.addresses.create(BitcoinAPI.generate_address)
    return user
  end

  def current_address
    self.addresses.last.address
  end

  def get_balance
    info = BitcoinAPI.get_info(self.current_address)
    info["final_balance"]
  end

  def enough_balance?(amount)
    amount ||= 0
    get_balance >= amount + FEE
  end

  def withdraw(amount, to_address)
    BitcoinAPI.send_tx(
      self.addresses.last,
      to_address,
      amount)
    return true
  end

end
