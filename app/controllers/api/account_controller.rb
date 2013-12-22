class Api::AccountController < ActionController::Base

  def index
    @user = User.find_by(slug: session[:slug])

    @account = {
      messages: {
        welcome: true,
        deposit: true, #!@user.enough_balance?
        withdraw: {
          default: true,
          success: false,
          error: false,
        }
      },
      deposit: {
        amount: 0.001
      },
      screenName: @user.screen_name,
      publicKey: @user.addresses.last.public_key,
      balance: 0.001, #@user.get_balance
      minerFee: 0.0001
    }

    # TODO: Add 401

    render json: @account
  end

  def withdraw
    ap params
    @user = User.find_by(slug: session[:slug])

    @account = {
      balance: 0,
      messages: {
        withdraw: {
          default: false,
          success: true,
          error: false
        }
      }
    }

    render json: @account
  end

end
