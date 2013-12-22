# 1 Bitcoin equals X
SATOSHIS = 100_000_000
MILLIBIT = 1000

raise "DecryptionKey Missing From Environment" if !ENV["DECRYPTION_KEY"] 
DECRYPTION_KEY = ENV["DECRYPTION_KEY"]
raise "Bitcoin Environment Not Set" if !ENV["BITCOIN_ENV"]
Bitcoin.network = ENV["BITCOIN_ENV"]
FEE = 10000


class Numeric
	def to_satoshi
		(self * 100_000_000).to_i
	end

	def to_millibit
		(self * 1000).to_i
	end
end
