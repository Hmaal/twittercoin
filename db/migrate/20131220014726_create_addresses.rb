class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :encrypted_private_key
      t.string :public_key
      t.integer :user_id

      t.timestamps
    end

    add_index :addresses, :encrypted_private_key
    add_index :addresses, :public_key
  end
end
