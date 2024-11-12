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
end