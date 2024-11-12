class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}    
        @bidding_open = true
    end

    def add_bid(attendee, amount)
        @bids[attendee] = amount
    end

    def current_highest_bid
        @bids.values.max
    end

    def add_bid(attendee, amount)
        @bids[attendee] = amount if @bidding_open
    end

    def current_high_bid
        @bids.values.max
    end

    def closed_bidding
        @bidding_open = false
    end
end