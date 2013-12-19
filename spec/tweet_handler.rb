require 'spec_helper'

describe 'TweetHandler | ', :vcr do

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
  end

  it "should have tweet, sender and parsed tweet" do
    expect(@handler.tweet).to eq(tweet)
    expect(@handler.sender).to eq(sender)
    expect(@handler.status_id).to eq(status_id)
    expect(@handler.parsed_tweet.info).to eq(info)
  end

  it "should save the tweet in db" do
    expect(Tweet.count).to be(0)
    @handler.save_tweet
    expect(Tweet.count).to be(1)
  end

  context "Valid Tweets | " do

    it "should check whether a @recipient exists" do

    end


  end


  context "Invalid Tweets" do

  end

end
