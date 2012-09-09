module Locu
  class Menu < LocuObject

    # a lot of the defaults are simply
    # hardcoded for the techcrunch
    # hackathon
    DEFAULTS = {
      :street_address => 'mission'
    }

    def initialize(host, path, api_key)
      super(host, path, api_key)
    end

    def get_by_name(name)
      @uri.query = formulate_query({:name => name})
      response = Net::HTTP.get_response @uri
      parse_response response
    end

  end
end
