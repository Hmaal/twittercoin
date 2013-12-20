require 'spec_helper'

# TODO: Occassionally clear VCR cache, and retest live
describe Tweet::Handler, :vcr do

  context "Valid Tweets:" do
    let(:content) { "@JimmyMcTester, keep it up! Here's a tip 0.01 BTC @tippercoin" }
    let(:sender) { "McTestor" }
    let(:status_id) { 123456789 }
    let(:info) {
      {
        recipient: "JimmyMcTester",
        amount: 1_000_000,
        sender: "McTestor"
      }
    }

    before(:each) do
      @user = create(:mctestor)

      @handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)
    end

    it "should have content, sender and parsed tweet" do
      expect(@handler.content).to eq(content)
      expect(@handler.sender).to eq(sender)
      expect(@handler.status_id).to eq(status_id)
      expect(@handler.parsed_tweet.info).to eq(info)
      expect(@handler.recipient).to eq('JimmyMcTester')
    end

    it "should save the tweet in db regardless" do
      expect(TweetTip.count).to eq(0)
      expect(@handler.save_tweet_tip).to eq(true)
      expect(TweetTip.count).to eq(1)
    end

    it "should create recipient if recipient not found in db" do
      expect(User.count).to eq(1)
      @handler.find_or_create_recipient
      expect(@handler.recipient_user.screen_name).to eq("JimmyMcTester")
      expect(User.count).to eq(2)
    end

    it "should create a new bitcoin address for new recipients" do
      @handler.find_or_create_recipient
      expect(@handler.recipient_user.addresses.first).to_not eq(nil)
    end

    context "Validity" do
      it "should have valid false by default" do
        expect(@handler.valid).to eq(false)
      end

      it "should build a valid sender reply message" do
        expect(@handler.sender_reply).to include("@McTestor", "successful")
      end

      it "should build a valid recipient reply message" do
        @handler.find_or_create_recipient
        @handler.recipient_reply_build
        expect(@handler.recipient_reply).to include("@JimmyMcTester", "tipped")
      end
    end

    # How to effectively test API?

    it "should push a transaction"

    it "should reply to sender"

    it "should reply to recipient"

  end


  context "Invalid Tweets" do

    let(:sender) { "McTestor" }
    let(:status_id) { 123456789 }

    it "should save the tweet in db"

    it "should return invalid if no user" do
      ap User.where(screen_name: sender).destroy_all

      expect(@handler.sender_user).to eq(nil)
      expect(@handler.valid?).to eq(false)
    end


    it "should, if no account, build the error message" do
      tweet = "JimmyMcTester, 0.001 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)

      handler.find_user(sender)
      handler.sender_reply_build
      expect(handler.sender_reply).to include("authenticate", "deposit")
    end

    it "should, if not enough balance, build the error message" do
      tweet = "JimmyMcTester, 1 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        tweet: tweet,
        sender: sender,
        status_id: status_id)

      handler.find_user(sender)
      handler.sender_reply_build
      expect(handler.sender_reply).to include("top up")
    end

    it "should, if 0 amount, build the error message" do
      tweet = "JimmyMcTester, 1 BTC, @tippercoin"
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
