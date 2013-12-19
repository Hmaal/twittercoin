class Tweet::Handler

  attr_accessor :tweet, :sender, :recipient,
  :sender_reply, :recipient_reply, :recipient_user, :sender_user,
  :status_id, :parsed_tweet, :valid

  def initialize(tweet: nil, sender: nil, status_id: nil)
    @tweet = tweet
    @sender = sender
    @status_id = status_id
    @parsed_tweet = Tweet::Parser.new(@tweet, @sender)
    @recipient = @parsed_tweet.info[:recipient]
  end

  def valid?
    return false if !@parsed_tweet.valid?
    return false if !@sender_user # TODO: Check against ActiveRecord

    return true
  end

  def sender_reply_build
    if valid?
      @sender_reply = Tweet::Message::Valid.sender(@recipient, @sender) and return
    end

    if @parsed_tweet.info[:amount].zero?
      @sender_reply = Tweet::Message::Invalid.zero_amount(@recipient) and return
    end

    if @parsed_tweet.direct_tweet?
      @sender_reply = Tweet::Message::Invalid.direct_tweet(@recipient) and return
    end

    if !@sender_user
      @sender_reply = Tweet::Message::Invalid.no_account(@recipient) and return
    end

    if @sender_user.enough_balance?
      @sender_reply = Tweet::Message::Invalid.not_enough_balance(@recipient) and return
    end

    @sender_reply = Tweet::Message::Invalid.unknown(@recipient)
  end

  def recipient_reply_build
    @recipient_reply = Tweet::Message::Valid.recipient(
      @recipient, @sender, @parsed_tweet.info[:amount])
  end

  def sender_reply_deliver
    TWITTER_CLIENT.update(@sender_reply, in_reply_to_status_id: @status_id)
  end

  def recipient_reply_deliver
    TWITTER_CLIENT.update(@recipient_reply, in_reply_to_status_id: @status_id)
  end

  def save_tweet
    Rails.logger.info("Writing tweet into DB")
    @sender_user = nil
  end

  def find_or_create_sender
    @sender_user = find_user(@sender) || create_user(@sender)
  end

  def find_or_create_recipient
    @recipient_user = find_user(@recipient) || create_user(@recipient)
  end

  # Returns ActiveRecord Object, or nil
  def find_user(screen_name)
    # User.where(screen_name: screen_name)
  end

  def create_user(screen_name)
    ## New @recipient
    # TwitterSearch.new(screen_name)

    # Rails.logger.info("Generating new Bitcoin address")
    # BitcoinAPI.generate_address

    # Rails.logger.info("Writing new @recipient into DB")
  end

  def push_tx
    # BitcoinAPI.push_tx()
  end

end
