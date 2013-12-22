### Creating
User.exists?(screen_name: "screenname")

# if False

@user = User.create({
  screen_name: "screenname",
  authenticated: true,
  uid: 123456789
})

# if True

@user = User.where(screen_name: "screenname").first

@tweet = @user.tweet_tips.new({
  content: content,
  sender_id: parsed_tweet.sender,
  recipient_id: parsed_tweet.sender
  api_tweet_id_str: tweet.id
})

@tweet.save

@user.tips.create({
  amount: 1000000,
  tweet_id: @tweet.id,
  recipient_id: @

})

@user.tweet_tips

### Profile Page Retrieving

@user = User.where(screen_name: "screenname").first
@user.screen_name
@user.authenticated

# from API
@user.get_description
@user.get_avatar_large
@user.get_avatar_small

# Should return
@tips = @user.tips

@tips.total_received
@tips.total_given

@tips.each do |tweet_tip|
  tweet_tip.sender.screen_name
  tweet_tip.sender.full_name
  tweet_tip.sender.avatar_small
  tweet_tip.sender.avatar_large
  tweet_tip.sender.address.public_key

  tweet_tip.received?
  tweet_tip.given?

  tweet_tip.transaction.tx_hash

  tweet_tip.recipient.screen_name
  tweet_tip.recipient.full_name
  tweet_tip.recipient.avatar_small
  tweet_tip.recipient.avatar_large
  tweet_tip.recipient.address.public_key

  tweet_tip.satoshis
  tweet_tip.amount
  tweet_tip.unit

  tweet_tip.tweet.get_link
end
