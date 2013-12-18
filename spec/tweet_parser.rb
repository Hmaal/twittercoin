require 'spec_helper'

describe 'TweetParser | ' do
  let(:sender) { "@sender" }

  context "Basic: " do

    before(:each) do
      @tweet = "@recipient, really good article, keep it up! Here's a tip 0.001 BTC @tippercoin"
      @t = TweetParser.new(@tweet, sender)
    end

    it "should return the correct bot(@tippercoin)" do
      expect(TweetParser::BOT).to eq("@tippercoin")
    end

    it "should not return recipient to be @tippercoin" do
      expect(@t.info[:recipient]).to_not be("@tippercoin")
    end

    it "should return mentions as array" do
      expect(@t.mentions.class).to be(Array)
    end

    it "should return amounts as array" do
      expect(@t.amounts.class).to be(Array)
    end

    it "should build a info hash" do
      expect(@t.info.class).to be(Hash)
      expect(@t.info.keys).to include(:recipient, :amount, :sender)
    end

    it "should return the correct sender" do
      expect(@t.info[:sender]).to eq("@sender")
    end

    it "should return the correct value" do
      amount = 100000
      expect(@t.info[:amount]).to eq(amount)
    end

  end

  context "Multiple Recipients OR Amounts: " do

    before(:each) do
      @tweet = "@recipient1, @recipient2, really good article, keep it up!
        Here's a tip 0.001 BTC but not 1 BTC @tippercoin"
      @t = TweetParser.new(@tweet, sender)
    end

    it "should identify multiple recipients" do
      expect(@t.multiple_recipients?).to eq(true)
    end

    it "should take the first recipient to be the real recipient" do
      expect(@t.info[:recipient]).to eq("@recipient1")
      expect(@t.info[:recipient]).to_not eq("@recipient2")
    end

    it "should take the first amount to be the real amount" do
      expect(@t.info[:amount]).to be(100000)
      expect(@t.amounts).to include(100000000)
    end
  end

  context "Invalid tweets: " do
    it "should contain an invalid attribute for invalid tweets" do
      tweet = "@recipient does this btc thing actually work? @tippercoin"
      t = TweetParser.new(tweet, sender)
      expect(t.valid?).to eq(false)
    end

    it "should be invalid if BOT is specified as first recipient" do
      tweet = "@tippercoin, @BrookeInVegas I still can't get anyone to accept a
        BitCoin. My first follower to request one, gets one (only if u r new 2 BTC)"
      t = TweetParser.new(tweet, sender)
      expect(t.valid?).to eq(false)
      expect(t.direct_tweet?).to eq(true)
    end

    it "should be invalid if amount is zero" do
      tweet = "@recipient1 really good article, keep it up! Here's a tip 0.000 BTC @tippercoin"
      t = TweetParser.new(tweet, sender)
      expect(t.valid?).to eq(false)
      expect(t.info[:amount]).to eq(0)
    end

  end

  context "Suffix Symbols: " do

    it "should extract/convert BTC to SATOSHIS" do
      tweet1 = "@recipient, really good article, keep it up! Here's a tip 0.041 BTC @tippercoin"
      # value = 0.041 * 100_000_000
      t1 = TweetParser.new(tweet1, sender)
      expect(t1.info[:amount]).to eq(4100000)

      tweet2 = "@recipient, really good article, keep it up! Here's a tip 2 BTC @tippercoin"
      t2 = TweetParser.new(tweet2, sender)
      expect(t2.info[:amount]).to eq(200000000)
    end

    it "should extract/convert mBTC to SATOSHIS" do
      tweet = "@recipient, really good article, keep it up! Here's a tip 5 mBTC @tippercoin"
      t = TweetParser.new(tweet, sender)
      # value = 5 * 100_000_000 / 1000
      expect(t.info[:amount]).to eq(500000)
    end

    it "should extract/convert beers to SATOSHIS"

    it "should extract/convert internets to SATOSHIS"

    it "should be extract both upper/lowercases of suffix symbols"

    it "should extract amounts with/without spaces of suffix symbols"

    it "should prefer suffix btc/BTC if multiple currency symbols"

  end

  context "Prefix Symbols" do
    it "should extract/convert $ to SATOSHIS"

    it "should extract/convert ฿ to SATOSHIS"

    it "should extract/convert B to SATOSHIS"

    it "should extract amounts with/without spaces of suffix symbols"

    it "should prefer suffix btc/BTC if multiple currency symbols"
  end


end

describe 'TweetParser Bulk Check' do

end
