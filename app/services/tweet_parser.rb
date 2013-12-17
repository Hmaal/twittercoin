class TweetParser

  attr_accessor :tweet, :info, :mentions, :amounts

  BOT = "@tippercoin"

  def initialize(tweet, sender)
    @tweet = tweet
    @mentions = Extractor::Mentions.parse(@tweet)
    @amounts = Extractor::Amounts.parse(@tweet)

    @info = {
      recipient: @mentions.first,
      amount: @amounts.first,
      sender: sender
    }
  end

  def valid?
    # Check if nil or 0 are in info values
    (@info.values & [nil, 0]).empty? && !direct_tweet?
  end

  def direct_tweet?
    @mentions.first == BOT
  end

  def multiple_recipients?
    @mentions.count > 2 # actual recipient + BOT
  end

  module Extractor
    module Mentions
      extend self

      # Accept: String
      # Returns: Array or Strings, or nil
      def parse(tweet)
        usernames = tweet.scan(/(@\w+)/).flatten
        return [nil] if usernames.blank?
        return usernames
      end

    end

    module Amounts
      extend self

      ### Supported Currency Symbols:

      # Accept: String
      # Returns: Array of Integers, or nil
      def parse(tweet)
        raw_numbers = tweet.scan(/(\d?+.?\d+)\s?BTC/i).flatten
        amounts_array = raw_numbers.map do |a|
          satoshi = (a.to_f * SATOSHIS).round(0)
        end
      end

    end
  end

end
