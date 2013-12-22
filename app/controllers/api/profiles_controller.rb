class Api::ProfilesController < ActionController::Base

  # TODO Authentication

  def show
    # TODO: Rails.cache.fetch


    @user = User.where(screen_name: params[:screen_name])
    @user = TipperClient.search_user(params[:screen_name])

    render json: @user
  end

end
