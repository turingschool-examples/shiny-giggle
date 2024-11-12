class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item unless @items.include?(item)
    end

    def item_names
      item_names = []
        @items.map do |item|
            item_names << item.name
        end
      item_names.uniq
    end

    def unpopular_items
        @items.select { |item| item.bids.empty? }
    end
end