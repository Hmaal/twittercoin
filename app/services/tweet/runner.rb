module Tweet::Runner
  extend self

  def execute(content: nil, sender: nil, status_id: nil)
    return if sender =~ /tippercoin/i

    ap 'handling ...'
    handler = Tweet::Handler.new(
      content: content,
      sender: sender,
      status_id: status_id
    )

    ap 'saving tweet ...'
    handler.save_tweet_tip

    ap 'checking validity ...'
    handler.check_validity

    # Short Circuit if Invalid
    if !handler.valid
      ap 'invalid, sending reply ...'
      return handler.sender_reply_deliver
    end

    ap 'finding/creating recipient ...'
    handler.find_or_create_recipient

    ap 'pushing tx ...'
    handler.push_tx

    ap 'delivering reply to sender ...'
    handler.sender_reply_deliver

    ap 'delivering reply to recipient ...'
    handler.recipient_reply_build
    handler.recipient_reply_deliver

  end

end

