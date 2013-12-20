class User < ActiveRecord::Base

  # Similar to a "Followings table"
  has_many :tips_received, class_name: "TweetTip", foreign_key: "recipient_id"
  has_many :tips_given, class_name: "TweetTip", foreign_key: "sender_id"

  has_many :addresses

  validates :screen_name, uniqueness: true, presence: true
  validates :api_user_id_str, uniqueness: true, presence: true


  def all_tips
    self.tips_received + self.tips_given
  end

end
