class SessionsController < ApplicationController

  def create
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]

    user = User.find_profile(auth["info"]["nickname"])
    ap user
    user ||= User.create_profile(auth["info"]["nickname"],
      uid: auth["uid"],
      via_oauth: true )

    session[:slug] = user.slug

    redirect_to "/#/account/", flash: {
      info: "Welcome!"
    }
  end

  def destroy
    session[:slug] = nil
    redirect_to "/", flash: {
      info: "See you next time!"
    }
  end

end
