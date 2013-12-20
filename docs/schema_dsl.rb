### DSL
@user = User.where(screen_name: "screenname").first

@tweet = @user.tweets.new({
  content: tweet,
  mentions: parsed_tweet.mentions
  amounts: parsed_tweet.amounts,
  unit: parsed_tweet.unit
  sender: parsed_tweet.sender
  valid: parsed_tweet.valid?
  api_tweet_id: tweet.id
})

@tweet.save

@user.tips.create({
  amount: 1000000,
  tweet_id: @tweet.id,
  recipient_id: @

})

@user.tweets

### Profile Page

@user = User.where(screen_name: "screenname").first
@user.screen_name
@user.authenticated

# from API
@user.description
@user.avatar_large
@user.avatar_small

# Should return
@tips = @user.tips

@tips.total_received
@tips.total_given

@tips.each do |tip|
  tip.sender.screen_name
  tip.sender.avatar_small
  tip.sender.avatar_large
  tip.sender.address.public_key

  tip.received?
  tip.given?

  tip.transaction.tx_hash

  tip.recipient.screen_name
  tip.recipient.avatar_small
  tip.recipient.avatar_large
  tip.recipient.address.public_key

  tip.satoshis
  tip.amount
  tip.unit

  tip.tweet.get_link
end
