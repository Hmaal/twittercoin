module Tweet::Message

  module Valid
    extend self

    def sender
      link = "tippercoin.com/#/profile/#{recipient}?tip=#{tip_id}"
      "#{sender}, congrats, your tip was successful! See it here #{link}"
    end

    def recipient
      link = "tippercoin.com/#/profile/#{recipient}"
      "Hi #{recipient}, #{sender} just tipped you #{amount / SATOSHIS} BTC! "\
      "See it here #{link}"
    end
  end

  module Invalid
    extend self

    def no_account(sender)
      link = "tippercoin.com/signup"
      "Hi #{sender}, complete your tip by authenticating via twitter and "\
      "making a deposit. #{link}"
    end

    def not_enough_balance
      link = "tippercoin.com/#/account/deposit?amount=#{amount}"
      "Hi #{sender}, complete your tip by topping up on your account with "\
      "#{amount / SATOSHIS} BTC. #{link}"
    end

    def unknown
      link = "tippercoin.com/#/documentation"
      "Hi #{sender}, sorry, I'm not sure what you meant :s. Please refer to #{link}"
    end

    def zero_amount
      link = "tippercoin.com/#/documentation"
      "Hi #{sender}, please tip 0.001 BTC or more. Refer to #{link}"
    end

    def direct_tweet
      link = "tippercoin.com/#/documentation"
      "Hi #{sender}, sorry, I'm not sure what you meant :s. Please refer to #{link}"
    end

  end
end
