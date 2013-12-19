class Tweet::Handler

  attr_accessor :tweet, :sender, :status_id :parsed_tweet, :valid

  def initialize(tweet: nil, sender: nil, status_id: nil)
    @tweet = tweet
    @sender = sender
    @status_id = status_id
    @parsed_tweet = Tweet::Parser.new(@tweet, @sender)
    @valid = @parsed_tweet.valid?
  end

  def build_sender_msg(valid: nil)
    if valid || @valid
      return Tweet::Message::Valid.sender(@sender)
    end

    if !@user
      return Tweet::Message::Invalid.no_account(@sender)
    end

    if @parsed_tweet.info[:amount].zero?
      return Tweet::Message::Invalid.zero_amount(@sender)
    end

    if @user.enough_balance?
      return Tweet::Message::Invalid.not_enough_balance(@sender)
    end

    if @parsed_tweet.direct_tweet?
      return Tweet::Message::Invalid.direct_tweet(@sender)
    end

    return Tweet::Message::Invalid.unknown(@sender)
  end

  def build_recipient_msg
    @recipient_msg = Tweet::Message::Valid.recipient(@sender)
  end

  def save_tweet
    Rails.logger.info("Writing tweet into DB")
    @user = nil
  end

  def find_or_create_recipient

  end

  def find_recipient
    # @recipient = User.where(screen_name: @parsed_tweet.info[:recipient])
  end

  def create_recipient
    ## New @recipient
    @recipient = TwitterSearch.new(@parsed_tweet.info[:recipient])

    Rails.logger.info("Generating new Bitcoin address")
    # BitcoinAPI.generate_address

    Rails.logger.info("Writing new @recipient into DB")
  end

  def push_tx
    # BitcoinAPI.push_tx()
  end

  def reply_to_sender
    TWITTER_CLIENT.update(@sender_msg, in_reply_to_status_id: @status_id)
  end

  def reply_to_recipient
    TWITTER_CLIENT.update(@recipient_msg, in_reply_to_status_id: @status_id)
  end

end
