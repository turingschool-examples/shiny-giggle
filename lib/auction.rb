class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        @items.map do |item|
            item.name
        end
    end

    def unpopular_items
        unpopular = @items.select do |item|
            item.bids.empty?
        end
        unpopular
    end

    def potential_revenue
        revenue = 0
        @items.each do |item|
            if !unpopular_items.include?(item)
                revenue += item.current_high_bid
            end
        end
        revenue
    end
end