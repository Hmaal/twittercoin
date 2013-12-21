Twittercoin::Application.routes.draw do
  root to: "application#index"

  # TODO Define Resource permission
  namespace :api, defaults: { format: :json }  do
    resources :profiles, param: :screen_name
  end

  get 'auth/twitter/callback' => "sessions#create"
  get '/signout' => "sessions#destroy"

end
