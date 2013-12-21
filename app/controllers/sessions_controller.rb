class SessionsController < ApplicationController

  def create
    info = request.env["omniauth.auth"]["body"]

    user = User.find_by(uid: info["id"].to_s)
    user ||= User.create_profile(info["screen_name"],
      uid: info["uid"],
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
