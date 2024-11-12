class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}
        @closed = false
    end

    def add_bid(attendee, bid)
        if @closed == false
            @bids[attendee] = bid
        else
            puts "Auction has closed for this time"
        end
    end

    def current_high_bid
        high_bid = []
        @bids.each do |bid|
            high_bid << bid[1]
        end
        high_bid.max
    end

    def close_bidding
        @closed = true
    end
end