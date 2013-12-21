class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]


    redirect_to "/"
  end

end
