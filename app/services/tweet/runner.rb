module Tweet::Runner
  extend self

  def execute(tweet: nil, screen_name: nil, status_id: nil)

    handler = Tweet::Handler.new(tweet: nil, screen_name: nil, status_id: nil)

    handler.save_tweet
    handler.find_user(sender)

    # Short Circuit if Invalid
    if !handler.valid?
      handler.sender_reply_build
      return handler.sender_reply_deliver
    end

    handler.find_or_create_recipient

    handler.push_tx

    handler.sender_reply_build
    handler.sender_reply_deliver

    handler.recipient_reply_build
    handler.recipient_reply_deliver

  end

end

