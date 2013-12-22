class Api::ProfilesController < ActionController::Base

  # TODO Authentication

  def show
    # TODO: Rails.cache.fetch

    # TODO: No user?


    @user = User.find_profile(params[:screen_name])
    @twitter_user = TipperClient.search_user(params[:screen_name])

    total_tips_given = 0
    total_tips_received = 0

    @tips = @user.all_tips.map do |tip|

      # Cached
      sender = TipperClient.search_user(tip.sender.screen_name)
      recipient = TipperClient.search_user(tip.recipient.screen_name)

      t = Tweet::Parser.new(tip.content, tip.screen_name)

      # Count tips
      giving = sender[:screenName] == params["screen_name"]
      total_tips_given += tip.transaction.amount if giving
      total_tips_received += tip.transaction.amount if !giving

      {
        sender: {
          screenName: sender[:screenName],
          avatarSmall: sender[:avatarSmall],
          css: giving ? "yellow" : "default"
        },
        recipient: {
          screenName: recipient[:screenName],
          avatarSmall: recipient[:avatarSmall],
          css: giving ? "default" : "yellow"
        },
        txDirection:  giving ? "primary" : "success",
        txHash: tip.transaction.try(:tx_hash),
        tweetLink: tip.build_link,
        amount: tip.transaction.try(:satoshis),
        other: {
          presence: true,
          amount: 1,
          unit: "beer"
        }
      }
    end

    @profile = {
      screenName: @twitter_user[:screenName],
      description: @twitter_user[:description],
      avatarLarge: @twitter_user[:avatarLarge],
      uid: @user.uid,
      authenticated: @user.authenticated,
      totalTipsGiven: total_tips_given,
      totalTipsReceived: total_tips_received,
      tips: @tips
    }


    render json: @profile
  end

end
