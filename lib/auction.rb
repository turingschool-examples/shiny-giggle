class Auction
    attr_reader :items, :attendees, :bids

    def initialize
        @items = []
        @attendees = []
        @bids = {}
    end

    def add_item(item)
        @items.push(item)
    end

    def item_names
      item_names_array = []

      @items.each do |item|
        item_names_array.push(item.name)
      end

      item_names_array
    end

    def place_bid(item, attendee, amount)
        item.add_bid(attendee, amount)
    end

    def unpopular_items
        unpopular = []
        @items.each do |item|
            unpopular << item if item.bids.empty?
        end
        unpopular
    end

    def potential_revenue
        sum_of_highest_bids = 0
        @items.each do |item|
            if !item.bids.empty?
                highest_bid = items.bids.values.max
            end
        end
    end
end