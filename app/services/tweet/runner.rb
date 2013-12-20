module Tweet::Runner
  extend self

  def execute(tweet: nil, sender: nil, status_id: nil)

    handler = Tweet::Handler.new(content: nil, sender: nil, status_id: nil)

    handler.save_tweet_tip

    handler.check_validity

    # Short Circuit if Invalid
    if !handler.valid
      return handler.sender_reply_deliver
    end

    handler.find_or_create_recipient

    handler.push_tx

    handler.sender_reply_deliver

    handler.recipient_reply_build
    handler.recipient_reply_deliver

  end

end

