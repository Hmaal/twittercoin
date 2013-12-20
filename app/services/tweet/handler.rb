class Tweet::Handler

  attr_accessor :content, :sender, :recipient,
  :sender_reply, :recipient_reply, :recipient_user, :sender_user,
  :status_id, :parsed_tweet, :valid

  def initialize(content: nil, sender: nil, status_id: nil)
    @content = content
    @sender = sender
    @status_id = status_id
    @parsed_tweet = Tweet::Parser.new(@content, @sender)
    @recipient = @parsed_tweet.info[:recipient]
    @sender_user = find_user(@sender)
    @recipient_user = find_user(@recipient)
    @valid = false
  end

  def save_tweet_tip
    @tweet_tip = TweetTip.new({
      content: @content,
      api_tweet_id_str: @status_id
    })

    @tweet_tip.save
  end

  # Returns ActiveRecord Object, or nil
  def find_user(screen_name)
    User.where("screen_name ILIKE ?", "%#{screen_name}%").first
  end

  def create_user(screen_name)
    result = TwitterSearch.new(screen_name)
    user = User.create({
      screen_name: result.screen_name,
      authenticated: false,
      api_user_id_str: result.api_user_id_str
    })
    user.addresses.create(BitcoinAPI.generate_address)

    return user
  end

  def find_or_create_recipient
    @recipient_user ||= create_user(@recipient)
  end

  # Checks Validity and builds sender reply
  def check_validity
    # Check user should be first
    if !@sender_user
      @sender_reply = Tweet::Message::Invalid.no_account(@sender) and return
    end

    if !@sender_user.enough_balance?
      @sender_reply = Tweet::Message::Invalid.not_enough_balance(@sender) and return
    end

    if @parsed_tweet.info[:amount] && @parsed_tweet.info[:amount].zero?
      @sender_reply = Tweet::Message::Invalid.zero_amount(@sender) and return
    end

    if @parsed_tweet.direct_tweet?
      @sender_reply = Tweet::Message::Invalid.direct_tweet(@sender) and return
    end

    if !@parsed_tweet.valid? # Other Unknown Error
      @sender_reply = Tweet::Message::Invalid.unknown(@sender) and return
    end

    @sender_reply = Tweet::Message::Valid.sender(@recipient, @sender)
    @valid = true
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

  def push_tx
    # BitcoinAPI.push_tx()
  end

end
