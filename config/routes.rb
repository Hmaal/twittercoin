Twittercoin::Application.routes.draw do
  root to: "application#index"

  namespace :api, defaults: { format: :json }  do
    get "/profiles/" => "profiles#build"
    get "/profiles/:screen_name" => "profiles#build"

    get "/account" => "account#index"
    post "/account" => "account#withdraw"
  end

  get 'auth/twitter/callback' => "sessions#create"
  get 'signout' => "sessions#destroy"

end
