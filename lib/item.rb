class Item
    attr_reader :name, :bids
     
    def initialize(name)
        @name = name
        @bids = ({})
    end

    def add_bid(attendee, bid)
        @bids[attendee] = bid
    end

    def current_high_bid
      current_high_bid = @bids.values.first

      @bids.values.each do |bid|
        if bid > current_high_bid
          current_high_bid = bid
        end
      end

      current_high_bid
    end
end