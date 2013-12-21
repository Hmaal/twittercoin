module BitcoinAPI
  extend self


  # TODO
  def generate_address
    {
      encrypted_private_key: SecureRandom.hex,
      public_key: SecureRandom.hex
    }
  end

end
