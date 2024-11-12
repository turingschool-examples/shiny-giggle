require 'pry'

class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
        binding.pry
    end

    def item_names
        raise NotImplementedError
    end
end