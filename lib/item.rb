class Item
    attr_reader :name, :bids, :closed
     
    def initialize(name)
        @name = name
        @bids = {}
        @closed = false
    end

    def add_bid(attendee, bid)
        if @closed == false
            bids[attendee] = bid
        else
            return "Bidding Closed!"
        end
    end

    def current_high_bid
        highest = @bids.max_by do |attendee, bid|
            bid
        end
        highest[1]
    end

    def close_bidding
        @closed = true

        "Closed!"
    end
end