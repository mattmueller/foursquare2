module Foursquare2
  class MashifyWrapper < Faraday::Response::Mashify
    def initialize(app = nil, opts = {})
      super(app, opts.merge(mash_class: HashWrapper))
    end
  end
end
