require 'spec_helper'

describe Address do
	it "decrypts private key" do
		payload = BitcoinAPI.generate_address()
		decrypted_key = AES.decrypt(payload[:encrypted_private_key], DECRYPTION_KEY)
		address = Address.new(payload.merge(:user_id => 1))
		address.save
		address.reload
		address.decrypt()
		address.private_key.should eq(decrypted_key)
	end
end
