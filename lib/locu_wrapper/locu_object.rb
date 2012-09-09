module Locu
  class LocuObject

    def initialize(host, path, api_key)
      @api_key    = api_key
      @uri        = URI(host+path)
    end

    def search_by(query_params)
      @uri.query = formulate_query(query_params)
      response = Net::HTTP.get_response @uri
      parse_response response
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

    def formulate_query(params_hash)
      params_with_key = params_hash.merge({:api_key => @api_key})
      URI.encode_www_form(params_with_key)
    end

    def parse_response(response)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end
  end
end
