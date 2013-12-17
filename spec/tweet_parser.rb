require 'spec_helper'

describe 'TweetParser Unit Check' do
  let(:sender) { "@sender" }

  context "Basic" do

    before(:each) do
      @tweet = "@recipient, really good article, keep it up! Here's a tip 0.001 BTC @tippercoin"
      @t = TweetParser.new(@tweet, sender)
    end

    it "should return the correct sender" do
      expect(@t.values[:sender]).to eq("@sender")
    end

    it "should return the correct value"

    it "should return the correct bot(@tippercoin)" do
      expect(TweetParser::BOT).to eq("@tippercoin")
    end

    it "should not return recipient to be @tippercoin" do
      expect(@t.recipients).to_not include("@tippercoin")
    end

    it "should return recipients as array of strings or nil"

    it "should return amounts as array of integers or nil"

    it "should build a values hash"

  end

  context "Multiple Recipients" do

    before(:each) do
      @tweet = "@recipient1, @recipient2, really good article, keep it up! Here's a tip 0.001 BTC @tippercoin"
      @t = TweetParser.new(@tweet, sender)
    end

    it "should identify multiple recipients" do
      expect(@t.multiple_recipients?).to eq(true)
    end

    it "should take the first recipient to be the real recipient" do
      expect(@t.values[:recipient]).to eq("@recipient1")
      expect(@t.values[:recipient]).to_not eq("@recipient2")
    end
  end


  context "Currency Symbols" do


    it "should extract/convert $ to SATOSHIS"

    it "should extract/convert BTC to SATOSHIS"

    it "should extract/convert mBTC to SATOSHIS"

    it "should extract/convert ฿ to SATOSHIS"

    it "should extract/convert B to SATOSHIS"

    it "should extract/convert beers to SATOSHIS"

    it "should extract/convert internets to SATOSHIS"

    it "should be extract both upper/lowercases on BTC/btc"

    it "should prefer btc/BTC if multiple currency symbols"

    it "should extract amounts with/without spaces"

  end

  context "Invalid tweets" do
    it "should contain an invalid attribute for invalid tweets"

    it "should be invalid if amount is zero"

    it "should be invalid if BOT is specified as first recipient"

  end


end

describe 'TweetParser Bulk Check' do

end
