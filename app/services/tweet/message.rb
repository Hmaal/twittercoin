module Tweet::Message

  module Valid
    extend self

    def recipient(recipient, sender, amount)
      link = "tippercoin.com/#/profile/#{recipient}"
      "Hi @#{recipient}, @#{sender} just tipped you #{amount / SATOSHIS.to_f} BTC! "\
      "See it here #{link}"
    end
  end

  module Invalid
    extend self

    def no_account(sender)
      link = "tippercoin.com/signup"
      "Hi @#{sender}, to send tips, please authenticate via twitter, "\
      "make a deposit, and then try again. #{link}"
    end

    def not_enough_balance(sender)
      # TODO: Include link with amount

      link = "tippercoin.com/#/account/deposit"
      "Hi @#{sender}, please top up on your account before sending this tip. #{link}"
    end

    def zero_amount(sender)
      link = "tippercoin.com/#/documentation"
      "Hi @#{sender}, please tip 0.001 BTC or more. Refer to #{link}"
    end

    def direct_tweet(sender)
      link = "tippercoin.com/#/documentation"
      "Hi @#{sender}, please try tipping someone else. Refer to #{link}"
    end

    def unknown(sender)
      link = "tippercoin.com/#/documentation"
      "Hi @#{sender}, sorry, I'm not sure what you meant :s. Please refer to #{link}"
    end

  end
end
