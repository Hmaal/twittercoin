module MtgoxService
  extend self
  BASE =  "https://data.mtgox.com/api/2/"

  def latest
    response = HTTParty.get("#{BASE}/BTCUSD/money/ticker_fast")
    response["data"]["last"]["value"].to_f
  end

end
