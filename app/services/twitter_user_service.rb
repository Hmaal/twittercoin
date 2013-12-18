class TwitterUserService

  attr_accessor :client

  def initialize

  end

  def tweet()
    TWITTER_CLIENT.update
  end

  def reply()
    TWITTER_CLIENT
  end

end
