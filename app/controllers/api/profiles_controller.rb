class Api::ProfilesController < ActionController::Base

  def build

    # TODO: No user?
    params[:screen_name] ||= User.find_by(slug: session[:slug]).screen_name

    @user = User.find_profile(params[:screen_name])
    @twitter_user = TipperClient.search_user(params[:screen_name])

    total_satoshis_given = 0
    total_satoshis_received = 0

    @tips = @user.all_tips.map do |tip|

      # Cached
      sender = TipperClient.search_user(tip.sender.screen_name)
      recipient = TipperClient.search_user(tip.recipient.screen_name)

      t = Tweet::Parser.new(tip.content, tip.screen_name)

      # Count tips
      giving = sender[:screenName] == params["screen_name"]
      total_satoshis_given += tip.satoshis if giving
      total_satoshis_received += tip.satoshis if !giving

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
        txHash: tip.tx_hash,
        tweetLink: tip.build_link,
        amount: tip.satoshis / SATOSHIS.to_f,
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
      totalTipsGiven: total_satoshis_given / SATOSHIS.to_f,
      totalTipsReceived: total_satoshis_received / SATOSHIS.to_f,
      publicKey: @user.addresses.first.public_key,
      tips: @tips
    }


    render json: @profile
  end

end
