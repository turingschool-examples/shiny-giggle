require 'pry'

class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        @items.each do |item|
            item
            binding.pry
        end
    end
end