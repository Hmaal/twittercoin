class TweetHandler

  # Don't delay listener
  # Long running tasks should go off to another job?

  def initialize(tweet, sender)
    @tweet = tweet
    @sender = sender
    @t = TweetParser.new(@tweet, @sender)

    # Create tweet entry in DB

    ### If Tweet Invalid
    # Reply to @sender with link
    # Multiple Recipients?



    ### If Tweet Valid

    # Check if new @recipient

    ## New @recipient
    @recipient = TwitterSearch.new(@t.info[:recipient])

    # Generate new Bitcoin address
    # BitcoinAPI.generate_address

    # create new @recipient in DB


    # Send Transaction to Recipient

    # Reply to @sender with link
    # message = "text"
    # TWITTER_CLIENT.update(message, in_reply_to_status_id:)
    # Reply to @recipient with link
    # message = "text"
    # TWITTER_CLIENT.update(message, in_reply_to_status_id:)


  end

  # Tester Delayed Job
  def deliver
    puts '1'
    sleep 2
    puts '2'
  end

end
