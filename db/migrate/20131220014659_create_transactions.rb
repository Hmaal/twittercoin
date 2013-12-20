class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :satoshis
      t.string :tx_hash
      t.integer :tweet_tip_id
      t.integer :address_id

      t.timestamps
    end
  end
end
