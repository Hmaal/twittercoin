require 'spec_helper'

describe BitcoinAPI do
	context(:get_unspents) do
		let(:from_address) { "1MTdy3kHGnuM9ARPWfSyAHPS8jdXf5kJJk" }
		it "get unspents from a given address" do
			total_value = 0.001.to_satoshi + FEE
			unspents = BitcoinAPI.get_unspents(from_address, total_value)
			unspents.length.should eq(1)
			unspents[0]["value"].should eq(0.005.to_satoshi)
		end

		it "gets both unspents" do
			total_value = 0.005.to_satoshi + FEE
			unspents = BitcoinAPI.get_unspents(from_address, total_value)
			unspents.length.should eq(2)
			unspents.unspent_value.should eq(0.006.to_satoshi)
		end

		it "raises error if amount in sufficient" do
			total_value = 0.006.to_satoshi + FEE
			expect {BitcoinAPI.get_unspents(from_address, total_value) }.to raise_error(BitcoinAPI::InsufficientAmount)
		end
	end
end
