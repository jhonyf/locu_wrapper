module Locu
  class Menu

    # a lot of the defaults are simply
    # hardcoded for the techcrunch
    # hackathon
    DEFAULTS = {
      :street_address => 'mission'
    }

    def initialize(connection, host, path, api_key)
      @connection = connection
      @api_key    = api_key
      @uri        = URI(host+path)
    end

    def get_by_name(name)
      @uri.query = formulate_query({:name => name})
      response = Net::HTTP.get_response @uri
    end

    private

    def formulate_query(params_hash)
      params_with_key = params_hash.merge({:api_key => @api_key})
      URI.encode_www_form(params_with_key)
    end

  end
end
