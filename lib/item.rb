class Item
    attr_reader :name, :bids, :bid, :bid_count
     
    def initialize(name)
        @name = name
        @bids = {}
        @bid_count = 0
    end

    def add_bid(attendee, bid)
        if @bid_count < 3
            @bids[attendee] = bid
            @bid_count += 1
        else
            "This item is no longer accepting bids."
        end
    end

    def current_high_bid
        highest = 0
        bids.each do |attendee, bid|
            if bid > highest
                highest = bid
            end
        end
        highest
    end

    def close_bidding
        if @bid_count >= 3
            "Bidding is closed for this item."

        elsif @bid_count < 3 && @bid_count > 0
            "This item is still accepting bids."

        else
            "This item is not up for auction."
        end
    end
end