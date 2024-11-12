class Attendee
    attr_reader :name, :budget
    
    def initialize(info)
        @name = info[:name]
        @budget = info[:budget].delete("$").to_i
        bidding_open = true
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