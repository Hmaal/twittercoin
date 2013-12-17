class TweetParser

  attr_accessor :tweet, :values

  def initialize(tweet)
    @tweet = tweet

    @values = build_values
  end

  def build_values
    return {
      recipient: "",
      sender: "",
      amount: 1
    }
  end

end
