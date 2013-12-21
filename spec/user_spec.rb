require 'spec_helper'

describe User do

  context "Creating User" do
    before(:each) do
      @user = build(:mctestor)
      @user2 = create(:jimmy_mctester)
    end

    it "should save user" do
      expect(@user.save).to eq(true)
    end

    it "should not save tweet tip with sender/recipient id" do
      @tweet_tip = @user.tips_given.new({
        content: "tweet blah",
        api_tweet_id_str: '123456'
      })

      expect(@tweet_tip.recipient_id).to eq(nil)
      expect(@tweet_tip.sender).to eq(@user.id)

      expect(@tweet_tip.save).to eq(false)
    end

    it "should save tips when all attributes given" do
      @user.save

      @tweet_tip = @user.tips_given.new({
        content: "tweet blah",
        api_tweet_id_str: '123456',
        recipient_id: @user2.id
      })

      expect(TweetTip.count).to eq(0)
      expect(@tweet_tip.save).to eq(true)
      expect(TweetTip.count).to eq(1)
    end

  end

  context "Profile Page" do

    before(:each) do
      # Create first

      # Retrive
      @user = User.find_by(screen_name: "JimmyMcTester")
    end

    it "should return screen_name" do
      expect(@user.screen_name).to eq("JimmyMcTester")
    end

    it "should be authenticated if authenticated via twitter" do
      # Mock Twitter?

      expect(@user.authenticated).to eq(true)
    end

    it "should return twitter profile data from api" do
      expect(@user.get_description).to include("Test", "Account")
      expect(@user.get_avatar_large).to_not be_blank
      expect(@user.get_avatar_small).to_not be_blank
    end

    context "Tips" do
      before(:each) do
        # Factory some tips

        @tips_given = @user.tips_given

        @first_tip = @tips_given.first
      end

      it "should build tips object" do
        expect(@tips_given).to_not be_blank
      end

      it "should build total tips" do
        expect(@tips_given.total_received).to eq(1_000_000)
        expect(@tips_given.total_given).to eq(2_000_000)
      end

      it "should build sender information" do
        expect(@first_tip.sender.screen_name).to eq("JimmyMcTester")
        expect(@first_tip.sender.full_name).to eq()
        expect(@first_tip.sender.avatar_small).to eq("")
        expect(@first_tip.sender.avatar_large).to eq("")
        expect(@first_tip.sender.address.public_key).to eq("")

      end

      it "should build recipient information" do
        expect(@first_tip.recipient.screen_name).to eq()
        expect(@first_tip.recipient.full_name).to eq()
        expect(@first_tip.recipient.avatar_small).to eq()
        expect(@first_tip.recipient.avatar_large).to eq()
        expect(@first_tip.recipient.address.public_key).to eq()
      end

      it "should build tx hash" do
        expect(@first_tip.transaction.tx_hash).to eq("asdf")
      end

      it "should build whether received/given" do
        expect(@first_tip.received?).to eq(true)
        expect(@first_tip.given?).to eq(false)
      end

      it "should build amount values" do
        expect(@first_tip.satoshis).to eq()
        expect(@first_tip.amount).to eq()
        expect(@first_tip.unit).to eq()
      end

      it "should build tweet link" do
        expect(@first_tip.tweet.get_link).to eq("http")
      end

    end

  end

end
