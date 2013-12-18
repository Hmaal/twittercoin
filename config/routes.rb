Twittercoin::Application.routes.draw do
  root to: "application#index"

  # TODO Define Resource permission
  namespace :api, defaults: { format: :json }  do
    resources :profiles, param: :screen_name

    get "streaming/message" => "streaming#message"
  end

end
