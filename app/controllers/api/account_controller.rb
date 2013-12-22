class Api::AccountController < ActionController::Base

  before_filter :build_account

  def index
    render json: @account
  end

  def withdraw
    ap params
    amount = (params[:withdrawAmount].to_f * SATOSHIS).to_i
    to_address = params[:toAddress]

    raise HoldUp

    result = @user.withdraw(amount, to_address)
    return WithdrawFailed unless result

    @account[:balance] = (@account[:balance] - (amount/SATOSHIS.to_f)).round(6)
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
    @balance = (@user.get_balance / SATOSHIS.to_f).round(6)
    @account = {
      messages: {
        welcome: true,
        deposit: @balance < MINIMUM_DEPOSIT / SATOSHIS.to_f,
        withdraw: {
          default: true,
          success: false,
          error: false,
        }
      },
      deposit: {
        amount: MINIMUM_DEPOSIT / SATOSHIS.to_f
      },
      screenName: @user.screen_name,
      address: @user.addresses.last.address,
      balance: @balance,
      minerFee: 0.0001
    }
  end

end
