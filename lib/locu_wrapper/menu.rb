# this is currently the same as
# a Venue - but i'm expecting them
# to diverge soon
module Locu
  class Menu < LocuObject
    def initialize(host, path, api_key)
      super(host, path, api_key)
    end
  end
end
