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
      link = "tippercoin.com/authenticate?user=#{sender}&r=#{rand}"
      "Hi @#{sender}, to send tips, please authenticate via twitter, "\
      "make a deposit, and then try again. #{link}"
    end

    def not_enough_balance(sender)
      # TODO: Include link with amount

      link = "tippercoin.com/#/account/deposit?r=#{rand}"
      "Hi @#{sender}, please top up on your account before sending this tip. #{link}"
    end

    def zero_amount(sender)
      link = "tippercoin.com/#/documentation?r=#{rand}"
      "Hi @#{sender}, please tip 0.001 BTC or more. Refer to #{link}"
    end

    def direct_tweet(sender)
      link = "tippercoin.com/#/documentation?r=#{rand}"
      "Hi @#{sender}, please try tipping someone else. Refer to #{link}"
    end

    def unknown(sender)
      link = "tippercoin.com/#/documentation?r=#{rand}"
      "Hi @#{sender}, sorry, I'm not sure what you meant :s. Please refer to #{link}"
    end

    def rand(limit: 2)
      SecureRandom.urlsafe_base64[0..limit]
    end

  end
end
