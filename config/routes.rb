Twittercoin::Application.routes.draw do
  root to: "application#index"

  namespace :api, defaults: { format: :json }  do
    resources :profiles, param: :screen_name
    get "/account" => "account#index"
    post "/account" => "account#withdraw"
  end

  get 'auth/twitter/callback' => "sessions#create"
  get 'signout' => "sessions#destroy"

end
