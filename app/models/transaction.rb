class Transaction < ActiveRecord::Base

  belongs_to :tweet_tip

  belongs_to :address

end
