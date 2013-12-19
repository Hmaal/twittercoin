module Tweet::Runner
  extend self

  def execute(tweet: nil, screen_name: nil, status_id: nil)

    handler = Tweet::Handler.new(tweet: nil, screen_name: nil, status_id: nil)

    handler.save_tweet
    handler.find_or_create_recipient

    handler.build_sender_msg

    # Short Circuit if Invalid
    return handler.reply_to_sender if !handler.valid

    handler.build_recipient_msg

    handler.push_tx

    handler.reply_to_sender
    handler.reply_to_recipient

  end

end

