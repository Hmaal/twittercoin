class Tweet::Handler

  attr_accessor :content, :sender, :recipient,
  :reply, :recipient_user, :sender_user,
  :status_id, :parsed_tweet, :valid, :state

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
      api_tweet_id_str: @status_id,
      screen_name: @sender
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

  def check_validity
    @valid = false
    # @state represents what went wrong, and associated message method
    return @state = :no_account if !@sender_user # Check first, else authenticate
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
      @status_id = nil
    end
  end

  def reply_deliver
    TWITTER_CLIENT.update(@reply, in_reply_to_status_id: @status_id)
  end

  def push_tx
    # BitcoinAPI.push_tx()
  end

end
