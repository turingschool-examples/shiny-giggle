class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items.unshift(item)
    end

    def item_names
        raise NotImplementedError
    end
end