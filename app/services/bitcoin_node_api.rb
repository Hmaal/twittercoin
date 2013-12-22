module BitcoinNodeAPI
    extend self
    ROOT = "http://blockchain.info/"

    # string address
    # response hash or nil
    def get_addr(address)
        get("address/" + address + "?format=json")
    end

    # string[] addresses
    # response hash or nil
    def multi_addr(addresses)
        get("multi_addr?active="+addresses.join("|"))
    end

    # string[] addresses
    # unspents[] or nil
    def unspent(addresses)
        get("unspent?active="+addresses.join("|"))["unspent_outputs"]
    end

    def get_tx(tx_hash)
        res = HTTParty.get "https://blockexplorer.com/rawtx/#{tx_hash}"
        JSON.parse(res.body)
    end

    def push_tx(hex, tx_hash)
        payload = {
          format: "plain",
          tx: hex,
          hash: tx_hash,
          cors: "true",
        }
        post("pushtx", payload)
    end

    def get(url)
        res = HTTParty.get(ROOT + url)
        return nil if error?(res)
        JSON.parse(res.body)
    end

    # TODO construct error message
    def post(url, payload)
        options = {body: payload}
        res = HTTParty.post(ROOT + url, options)
        raise "TODO" if res.code >= 400
        res.body
    end

    # Have to do this cos blockchain info API is crappy
    def error?(res)
        res.code >= 400 || JSON.parse(res.body)["error"]
    end

end
