require 'spec_helper'

describe Tweet::Handler, :vcr do

  context "Valid Tweets:" do
    let(:tweet) { "@recipient, keep it up! Here's a tip 0.01 BTC @tippercoin" }
    let(:sender) { "@sender" }
    let(:status_id) { 123456789 }
    let(:info) {
      {
        recipient: "@recipient",
        amount: 1_000_000,
        sender: "@sender"
      }
    }

    before(:each) do
      @handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)


      @handler.find_or_create_sender
    end

    it "should have tweet, sender and parsed tweet" do
      expect(@handler.tweet).to eq(tweet)
      expect(@handler.sender).to eq(sender)
      expect(@handler.status_id).to eq(status_id)
      expect(@handler.parsed_tweet.info).to eq(info)
      expect(@handler.recipient).to eq('@recipient')
    end

    it "should determine whether tweet is valid" do
      # No User
      expect(@handler.valid?).to eq(true)
    end

    it "should save the tweet in db" do
      expect(Tweet.count).to be(0)
      @handler.save_tweet
      expect(Tweet.count).to be(1)
    end

    it "should try to find recipient in db"

    it "should create recipient if recipient not found in db"

    it "should build a valid sender reply message" do
      @handler.sender_reply_build
      expect(@handler.sender_reply).to include("successful")
    end

    it "should build a valid recipient reply message" do
      @handler.recipient_reply_build
      expect(@handler.recipient_reply).to include("@recipient", "tipped")
    end

    it "should push a transaction"

    # How to effectively test API?

    it "should reply to sender"

    it "should reply to recipient"

  end


  context "Invalid Tweets" do

    let(:sender) { "@sender" }
    let(:status_id) { 123456789 }

    it "should save the tweet in db"

    it "should, if no account, build the error message" do
      tweet = "@sender, 0.001 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)

      handler.find_user(sender)
      handler.sender_reply_build
      expect(handler.sender_reply).to include("authenticate", "deposit")
    end

    it "should, if not enough balance, build the error message" do
      tweet = "@sender, 1 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)

      handler.find_user(sender)
      handler.sender_reply_build
      expect(handler.sender_reply).to include("top up")
    end

    it "should, if 0 amount, build the error message" do
      tweet = "@sender, 1 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)

      handler.find_user(sender)
      handler.sender_reply_build
      expect(handler.sender_reply).to include('tip', 'more')
    end

    it "should, if direct tweet, build the error message"

    it "should, otherwise, build a generic error message"

    it "should reply to sender the error message to sender"

  end

end
