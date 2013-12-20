class Address < ActiveRecord::Base

  belongs_to :user

  has_many :transactions

  validates :encrypted_private_key, presence: true, uniqueness: true
  validates :public_key, presence: true, uniqueness: true
  validates :user_id, presence: true

end
