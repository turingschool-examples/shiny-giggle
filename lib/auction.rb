class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        names = []
        @items.each do |item|
            names << item.name
        end
        names
    end

    def unpopular_items
        unpopular_items = []
        @items.each do |item|
            if item.bids.empty?
                unpopular_items << item
            end
        end
        unpopular_items
    end

    def potential_revenue
        potential_revenue = 0
        @items.each do |item|
            if item.current_high_bid != nil
                potential_revenue += item.current_high_bid
            end
        end
        potential_revenue
    end

    def bidders
        names = []
        @items.each do |item|
            all_bidders_for_item = item.bids.keys

            all_bidders_for_item.each do |bidder|
                if !names.include?(bidder.name)
                    names << bidder.name
                end
            end
        end
        names
    end

    def bidder_objects
        bidder_objects = []
        @items.each do |item|
            all_bidders_for_item = item.bids.keys

            all_bidders_for_item.each do |bidder|
                if !bidder_objects.include?(bidder)
                    bidder_objects << bidder
                end
            end
        end
        bidder_objects
    end
end