require 'spec_helper'

# TODO: Occassionally clear VCR cache, and retest live
describe Tweet::Handler, :vcr do

  let(:sender) { "McTestor" }
  let(:status_id) { 2253000787 }

  context "Basic Handling:" do
    let(:content) { "@JimmyMcTester, keep it up! Here's a tip 0.01 BTC @tippercoin" }
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

    it "should have valid false by default" do
      expect(@handler.valid).to eq(false)
    end

    # How to effectively test API?

    it "should push a transaction"

    it "should reply to sender"

    it "should reply to recipient"

    it "should reply to recipient"

  end

  context "Check Validity" do

    it "should, if no account, build the error message" do
      content = "@JimmyMcTester, 0.001 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(false)
      expect(handler.sender_reply).to include("authenticate", "deposit", sender)
    end


    it "should, if 0 amount, build the error message" do
      content = "@JimmyMcTester, 0 BTC, @tippercoin"
      create(:mctestor)
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(false)
      expect(handler.sender_reply).to include('tip', 'more', sender)
    end

    it "should, if direct tweet, build the error message" do
      content = "@tippercoin, 1 BTC, @otherdude"
      create(:mctestor)
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(false)
      expect(handler.sender_reply).to include('someone', 'else', sender)
    end

    # TODO: Mock this!
    it "should, if not enough balance, build the error message" do
      content = "@JimmyMcTester, 1 BTC, @tippercoin"
      create(:mctestor)
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(false)
      expect(handler.sender_reply).to include("top", "up")
    end

    it "should, otherwise, build a generic error message" do
      content = "Does this actually work @tippercoin"
      create(:mctestor)
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(false)
      expect(handler.sender_reply).to include("not", "meant")
    end

    it "should build a valid sender reply message" do
      create(:mctestor)
      content = "@JimmyMcTester, 0.001 BTC, @tippercoin"
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(true)
      expect(handler.sender_reply).to include("@McTestor", "successful")
    end

    it "should build a valid recipient reply message" do
      content = "@JimmyMcTester, 0.001 BTC, @tippercoin"
      create(:mctestor)
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      handler.check_validity
      expect(handler.valid).to eq(true)
      handler.find_or_create_recipient
      handler.recipient_reply_build
      expect(handler.recipient_reply).to include("@JimmyMcTester", "0.001", "tipped")
    end

  end

  context "Edge Cases" do
    it "should search for screen_name regardless of casing" do
      create(:mctestor)
      # This is lowercase, twitter api actually return titleized
      content = "@mctestor, 0.0001 BTC @tippercoin"
      handler = Tweet::Handler.new(
        content: content,
        sender: sender,
        status_id: status_id)

      expect(handler.recipient_user).to_not eq(nil)
      expect(handler.recipient_user.screen_name).to eq("McTestor")
    end

    it "should not duplicate users when screen_names have different casing" do
      user = build(:mctestor)
      expect(user.save).to eq(true)
      user2 = build(:mctestor_lower)
      expect(user2.save).to eq(false)
    end
  end

end
