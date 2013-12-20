class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :encrypted_private_key, null: false
      t.string :public_key, null: false
      t.integer :user_id

      t.timestamps
    end

    add_index :addresses, :encrypted_private_key
    add_index :addresses, :public_key
  end
end
