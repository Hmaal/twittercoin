class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :satoshis, null: false
      t.string :tx_hash, null: false
      t.integer :tweet_tip_id
      t.integer :address_id

      t.timestamps
    end
  end
end
