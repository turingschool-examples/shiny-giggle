class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}
        @close_bidding = false
    end

    def add_bid(attendee, bid)
        if @close_bidding == false
            @bids[attendee] = bid
        else
            return "Bidding time is over"
        end
    end

    def current_high_bid
        @bids.values.max
    end

    def close_bidding
        @close_bidding = true
    end
end