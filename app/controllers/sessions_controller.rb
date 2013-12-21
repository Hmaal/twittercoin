class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by(uid: auth["uid"].to_s)
    user ||= User.create_profile(auth["info"]["nickname"],
      uid: auth["uid"],
      via_oauth: true )

    session[:user_id] = user.id

    redirect_to "/", flash: {
      info: "Welcome!"
    }
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", flash: {
      info: "See you next time!"
    }
  end

end
