module Locu
  class LocuObject

    def initialize(host, path, api_key)
      @api_key    = api_key
      @path = host+path
    end

    # Returns venue details
    def get(id)
      uri = URI(@path + id + "/")
      uri.query = formulate_query({})
      parse uri
    end

    def search_by(query_params)
      uri = URI(@path + "/search/")
      uri.query = formulate_query(query_params)
      parse uri
    end

    def method_missing(method, *args, &block)
      # this allaws you do do something like
      # search_by_name_and_location(name, location)
      if method.to_s =~ /^search_by_(.+)$/
        attrs = $1.split('_and_')
        params = Hash[attrs.zip args]
        search_by(params)
      else
        super
      end
    end

    def respond_to?(meth)
      if meth.to_s =~ /^search_by_.*$/
        true
      else
        super
      end
    end

    private
    def parse(uri)
      response = Net::HTTP.get_response uri
      parse_response response
    end
    def formulate_query(params_hash)
      params_with_key = params_hash.merge({:api_key => @api_key})
      URI.encode_www_form(params_with_key)
    end

    def parse_response(response)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end
  end
end
