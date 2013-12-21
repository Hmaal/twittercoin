class Tweet::Handler

  attr_accessor :content, :sender, :recipient,
  :reply, :recipient_user, :sender_user,
  :status_id, :parsed_tweet, :valid, :state,
  :reply_id

  def initialize(content: nil, sender: nil, status_id: nil)
    @content = content
    @sender = sender
    @status_id = status_id
    @reply_id = status_id
    @parsed_tweet = Tweet::Parser.new(@content, @sender)
    @valid = false
    @recipient = @parsed_tweet.info[:recipient]
    @sender_user = find_user(@sender) || create_user(@sender)
    @recipient_user = find_user(@recipient) || create_user(@recipient)
  end

  def save_tweet_tip
    @tweet_tip = @sender_user.tips_given.new({
      content: @content,
      screen_name: @sender,
      api_tweet_id_str: @status_id,
      recipient_id: @recipient_user.id
    })

    @tweet_tip.save
  end

  # Returns ActiveRecord Object, or nil
  def find_user(screen_name)
    User.find_profile(screen_name)
  end

  def create_user(screen_name)
    User.create_profile(screen_name)
  end

  def check_validity
    @valid = false
    # @state represents what went wrong, and associated message method
    return @state = :unauthenticated if !@sender_user.authenticated
    return @state = :not_enough_balance if !@sender_user.enough_balance?
    return @state = :zero_amount if @parsed_tweet.info[:amount].try(:zero?)
    return @state = :direct_tweet if @parsed_tweet.direct_tweet?
    return @state = :unknown if !@parsed_tweet.valid? # Other Unknown Error
    @valid = true
  end

  def reply_build
    if @valid
      @reply = Tweet::Message::Valid.recipient(
        @recipient, @sender, @parsed_tweet.info[:amount])
    else
      @reply = Tweet::Message::Invalid.send(@state, @sender)
      @reply_id = nil
    end
  end

  def reply_deliver
    TWITTER_CLIENT.update(@reply, in_reply_to_status_id: @reply_id)
  end

  def push_tx
    # transaction = BitcoinAPI.push_tx()
    # @tweet_tip.transactions.new({})

  end

end
