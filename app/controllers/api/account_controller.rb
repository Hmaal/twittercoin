class Api::AccountController < ActionController::Base

  before_filter :build_account

  def index
    render json: @account
  end

  def withdraw
    ap params

    @account[:balance] = 0
    @account[:messages][:withdraw] = {
      default: false,
      success: true,
      error: false
    }

    render json: @account
  end

  protected

  def build_account
    # TODO: Add 401
    return unless session[:slug]

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
      address: @user.addresses.last.address,
      balance: 0.001, #@user.get_balance
      minerFee: 0.0001
    }
  end

end
