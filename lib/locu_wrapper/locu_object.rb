module Locu
  class LocuObject

    def initialize(host, path, api_key)
      @api_key    = api_key
      @uri        = URI(host+path)
    end

    private

    def formulate_query(params_hash)
      params_with_key = params_hash.merge({:api_key => @api_key})
      URI.encode_www_form(params_with_key)
    end

    def parse_response(response)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end
  end
end
