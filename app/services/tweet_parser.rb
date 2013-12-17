class TweetParser

  attr_accessor :tweet, :values, :recipients, :amounts

  BOT = "@tippercoin"

  def initialize(tweet, sender)
    @tweet = tweet
    @recipients = Extractor::Recipients.parse(@tweet)
    @amounts = Extractor::Amounts.parse(@tweet)

    @values = {
      recipient: @recipients.first,
      amount: @amounts.first,
      sender: sender
    }
  end

  def valid?
    !@values.values.include?(nil)
  end

  def multiple_recipients?
    @recipients.count > 1
  end

  module Extractor
    module Recipients
      extend self

      # Accept: String
      # Returns: Array or Strings, or nil
      def parse(tweet)
        usernames = tweet.scan(/(@\w+)/).flatten
        usernames.delete(BOT)
        return [nil] if usernames.blank?
        return usernames
      end

    end

    module Amounts
      extend self

      ### Supported Currency Symbols:
      # ...

      # Accept: String
      # Returns: Array of Integers, or nil
      def parse(tweet)
        return [nil]
      end

    end
  end

end
