class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        item_names = []
        @items.each do |item|
            item_names << item.name
        end
        item_names
    end

    def unpopular_items
        no_bid_items = []
        @items.each do |item| #go thru each item
            if item.bids.count == 0 #check if its bids hash has any key:value pairs
                no_bid_items << item
            end
        end
        no_bid_items
    end

    def potential_revenues
        revenue_sum = 0
        @items.each do |item| #go thru each item
            if item.bids.count > 0 #make sure it has a bid
                revenue_sum += item.current_high_bid #add its highes bid to the total
            end
        end
        revenue_sum
    end
end