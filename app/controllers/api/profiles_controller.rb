class Api::ProfilesController < ActionController::Base

  # TODO Authentication

  def show
    # TODO: Rails.cache.fetch

    # TODO: No user?


    @user = User.find_profile(params[:screen_name])
    @twitter_user = TipperClient.search_user(params[:screen_name])



    # TODO: Avoid repetitive calls

    @tips = @user.all_tips.map do |tip|
      {
        sender: {
          screenName: tip.sender.screenName
          avatarSmall: tip.sender.avatarSmall
        },
        receiver: {
          screenName: tip.receiver.screenName,
          avatarSmall: tip.receiver.avatarSmall
        },
        txHash: tip.transaction.tx_hash,
        tweetLink: tip.build_link,
        amount: tip.transaction.satoshis / SATOSHIS,
        other: {
          presence: true,
          amount: 1,
          unit: "Beer"
        }
      }
    end



    @profile = {
      screenName: @twitter_user[:screenName],
      description: @twitter_user[:description],
      avatarLarge: @twitter_user[:avatarLarge],
      uid: @user.uid,
      authenticated: @user.authenticated,
      totalTipsGiven: 0.011,
      totalTipsReceived: 1.14,
      tips: [
        {
          sender: {
            screenName: 1,
            avatarSmall: 1
          },
          receiver: {
            screenName: 1,
            avatarSmall: 1
          },
          txHash: 1,
          tweetLink: 1,
          amount: 0.001,
          other: {
            presence: true,
            amount: 1,
            unit: "Beer"
          }
        }
      ]
    }


    render json: @profile
  end

end
