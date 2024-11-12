class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}
    end

    def add_bid(name, bid)
        @bids[name] = bid
    end

    def current_high_bid 
        highest_bid = 0
        @bids.each do |name, bid|
            if bid > highest_bid
                highest_bid = bid
            end
        end
        highest_bid
    end
end