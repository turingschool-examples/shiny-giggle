class Item
    attr_reader :name, :bids, :bidding_open
     
    def initialize(name)
        @name = name
        @bids = ({})
        @bidding_open = true
    end

    def add_bid(attendee, bid)
        if @bidding_open
            @bids[attendee] = bid
            
        end
    end

    def bidders
        @bids.keys.map(&:name).uniq
    end

    def current_high_bid
        return nil if @bids.empty?
        @bids.values.max
    end

    def close_bidding
      @bidding_open = false
      "Bidding is now closed for #{@name}."
    end
end