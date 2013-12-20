module BitconNodeAPI
    extend self
    ROOT = "http://blockchain.info/"

    # string address
    # response hash or nil
    def get_addr(address)
        res = get("address/" + address + "?format=json")
        return nil if error?(res)
        JSON.parse(res.body)
    end

    # []string addresses
    # response hash or nil
    def multi_addr(addresses)
        res = get("multi_addr?active="+addresses.join("|"))
        return nil if error?(res)
        JSON.parse(res.body)
    end

    def get(url)
        HTTParty.get(ROOT + url)
    end

    # Have to do this cos blockchain info API is crappy
    def error?(res)
        res.code >= 400 || JSON.parse(res.body)["error"]
    end
    
end
