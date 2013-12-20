class TweetTip < ActiveRecord::Base

  # Recipient/Sender is like the "Followings table"
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  has_one :transaction

  validates :content, presence: true, uniqueness: true

end
