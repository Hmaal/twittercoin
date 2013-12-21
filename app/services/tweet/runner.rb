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
      ap 'invalid, buildling/deliver reply ...'
      handler.reply_build
      handler.reply_deliver
      return
    end

    ap 'pushing tx ...'
    handler.push_tx

    ap 'building/delivering reply ...'
    handler.reply_build
    handler.reply_deliver

  end

end

