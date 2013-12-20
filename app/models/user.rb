class User < ActiveRecord::Base

  # Recipient/Sender is like the "Followings table"
  has_many :recipients, class_name: "TweetTip", foreign_key: "recipient_id"
  has_many :senders, class_name: "TweetTip", foreign_key: "sender_id"

  has_many :addresses

end
