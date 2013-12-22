class CreateTweetTips < ActiveRecord::Migration
  def change
    create_table :tweet_tips do |t|
      t.string :content
      t.string :screen_name
      t.string :api_tweet_id_str
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :satoshis
      t.string :tx_hash

      t.timestamps
    end

    add_index :tweet_tips, :content
  end
end
