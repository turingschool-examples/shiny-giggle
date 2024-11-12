class Item
    attr_reader :name, :bids, :closed
     
    def initialize(name)
        @name = name
        @bids = {}
        @closed = false
    end
    
    def closed?
        @closed
    end

    def add_bid(attendee, bid)
        if @closed == false
            @bids[attendee] = bid
        end
    end

    def current_high_bid
        @bids.max_by do |attendee, bid|
            bid
        end[1]
    end

    def close_bidding
        @closed = true
    end
end