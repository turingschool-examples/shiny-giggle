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
end