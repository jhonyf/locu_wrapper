module Locu
  class Client

    API_VERSION = 'v1_0'

    DEFAULTS = {
      :host => 'http://api.locu.com'
    }

    # adding only a menu for now, should add
    # venues later
    attr_reader :menu, :venue

    def initialize(api_key)
      @api_key = api_key
      @config  = DEFAULTS
      @host    = @config[:host]
      setup_attributes
    end

    private

    def setup_attributes
      menu_path  = "/#{API_VERSION}/menu_item/search/"
      venue_path = "/#{API_VERSION}/venue/search/"

      @menu  = Locu::Menu.new(@connection, @host, menu_path, @api_key)
      @venue = Locu::Menu.new(@connection, @host, venue_path, @api_key)
    end
  end
end
