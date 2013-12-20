class Transaction < ActiveRecord::Base

  belongs_to :tweet_tip

  belongs_to :address

  validates :satoshis, presence: true
  validates :tx_hash, presence: true, uniqueness: true
  validates :tweet_tip_id, presence: true

end
