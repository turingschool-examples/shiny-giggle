class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = {}
    end

    def add_bid(attendee, bid)
        bids[attendee] = bid
    end

    def current_high_bid
        highest = @bids.max_by do |attendee, bid|
            bid
        end
        highest[1]
    end
end