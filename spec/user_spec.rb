require 'spec_helper'

describe User do

  context "Creating User" do
    before(:each) do
      @user = User.create(screen_name)
    end

    @tweet = @user.tweets.new({
      content: tweet,
      mentions: parsed_tweet.mentions,
      amounts: parsed_tweet.amounts,
      unit: parsed_tweet.unit,
      sender: parsed_tweet.sender,
      valid: parsed_tweet.valid?,
      api_tweet_id: tweet.id
    })

    it "should save user" do
      expect(@tweet.save).to eq(true)
    end

    it "should create tips" do
      @user.tweet_tips.create({
        amount: 1000000,
        tweet_id: @tweet.id,
        recipient_id: 12

      })

      expect(@user.tweet_tips.count).to eq(1)
    end

    it "should perform validations"

  end

  context "Profile Page" do

    before(:each) do
      # Create first

      # Retrive
      @user = User.where(screen_name: "JimmyMcTester").first
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

        @tweet_tips = @user.tweet_tips

        @first_tip = @tweet_tips.first
      end

      it "should build tips object" do
        expect(@tweet_tips).to_not be_blank
      end

      it "should build total tips" do
        expect(@tweet_tips.total_received).to eq(1_000_000)
        expect(@tweet_tips.total_given).to eq(2_000_000)
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
