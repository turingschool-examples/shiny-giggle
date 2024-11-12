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

    def potential_revenue
        @items.sum do |item|
            item.current_high_bid || 0
        end
        # total_highest = []
        # require 'pry'; binding.pry
        # @items.each do |item|
        #     total_highest << @item.current_high_bid
        # end
        # total_highest.sum
    end
end