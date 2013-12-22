class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :encrypted_private_key
      t.string :public_key
      t.string :address
      t.references :user

      t.timestamps
    end

    add_index :addresses, :address
  end
end
