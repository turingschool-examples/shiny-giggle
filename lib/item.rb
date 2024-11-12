class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}
    end

    def add_bid(info, bid)
        if @bids == false
          return "Bidding closed, please choose another item."
        end
        @bids[info] = bid
    end

    def current_high_bid
        high_bid = []
        @bids.each do |k, v|
            high_bid << v
        end
        high_bid.sort
        high_bid.last
    end

    def close_bidding
      @bids = false
    end
end