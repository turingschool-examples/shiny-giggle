require 'pry'

class Auction
    attr_reader :items, :item_names

    def initialize
        @items = []
        @item_names = []
        @bids = {}
    end

    def add_item(item)
        @items << item
    end

    def item_names
        @items.each do |item|
            @item_names << item.name
        end
    @item_names
    end

    def unpopular_items
        unpopular_items_array = []

        @items.each do |item|
            if item.bids.empty?
                unpopular_items_array << item
            end
        end
        unpopular_items_array
    end
end