class Item
    attr_reader :name, :bids, :bidding_is_closed
     
    def initialize(name)
        @name = name
        @bids = {}
        @bidding_is_closed = false
    end

    def add_bid(attendee, amount)
        if !@bidding_is_closed 
          @bids[attendee] = amount
        end
    end

    def current_high_bid #need largest number from the values in the hash
      @bids.values.max  
    end

    def close_bidding
      @bidding_is_closed = true
    end
end