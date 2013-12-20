module BitcoinAPI
  extend self

  # TODO: Decryption Key
  DECRYPTION_KEY = ENV["DECRYPTION_KEY"]

  # TODO: enryption
  def generate_address()
    private_key, public_key = Bitcoin::generate_key
    address = Bitcoin::pubkey_to_address(public_key)
    {
      encrypted_private_key: private_key,
      public_key: public_key,
      address: address
    }
  end

  # string address
  def get_info(address)
    BitconNodeAPI.get_addr(address)
  end

  def tx(from_address, to_address, amount)

  end
end
