 DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == ENV["DJ_USERNAME"] && password == ENV["DJ_PASSWORD"]
  end
