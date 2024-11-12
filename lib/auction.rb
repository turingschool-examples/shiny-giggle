class Auction
    attr_reader :items, :bidders

    def initialize
        @items = []
        @bidders = []
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

    def potential_revenue
        @items.sum do |item|
            item.current_high_bid || 0
        end
    end

    def add_attendee(attendee)
        @bidders << attendee.name
    end
end