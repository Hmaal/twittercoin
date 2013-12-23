module Tweet::Message

  module Valid
    extend self

    def recipient(recipient, sender, amount)
      link = "tippercoin.com/#/profile/#{recipient}?direct=true&r=#{rand}"
      "Hi @#{recipient}, @#{sender} just tipped you #{amount / SATOSHIS.to_f} BTC! "\
      "See it here #{link}"
    end

    def rand(limit: 2)
      SecureRandom.urlsafe_base64[0..limit]
    end
  end

  module Invalid
    extend self

    def unauthenticated(sender)
      link = "tippercoin.com/auth/twitter?r=#{rand}"
      "Hey there @#{sender}, to start tipping, please authenticate via twitter "\
      "and make a deposit. Thanks! #{link}"
    end

    def not_enough_balance(sender)
      # TODO: Include link with amount

      link = "tippercoin.com/auth/twitter?r=#{rand}"
      "Hi @#{sender}, please top up on your account before sending this tip. #{link}"
    end

    def enough_confirmed_unspents(sender)
      link = "tippercoin.com/#/account/deposit?r=#{rand}"
      "Hi @#{sender}, you don't have enough confirmed unspents, pls wait for a few mins! #{link}"
    end

    def negative_amount(sender)
      link = "tippercoin.com/#/documentation?r=#{rand}"
      "Hi @#{sender}, You can't send negative amounts! #{link}"
    end

    def zero_amount(sender)
      link = "tippercoin.com/#/how-it-works?r=#{rand}"
      "Hi @#{sender}, please tip 0.001 BTC or more. Refer to #{link}"
    end

    def direct_tweet(sender)
      link = "tippercoin.com/#/how-it-works?r=#{rand}"
      "Hi @#{sender}, please try tipping someone else. Refer to #{link}"
    end

    def unknown(sender)
      link = "tippercoin.com/#/how-it-works?r=#{rand}"
      "Hi @#{sender}, sorry, I'm not sure what you meant :s. Please refer to #{link}"
    end

    def rand(limit: 2)
      SecureRandom.urlsafe_base64[0..limit]
    end

  end
end
