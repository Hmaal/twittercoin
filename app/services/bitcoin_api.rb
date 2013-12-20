module BitcoinAPI
  extend self

  def generate_address()
    private_key, public_key = Bitcoin::generate_key
    address = Bitcoin::pubkey_to_address(public_key)
    encrypted_private_key = AES.encrypt(private_key, DECRYPTION_KEY)
    {
      encrypted_private_key: encrypted_private_key,
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
