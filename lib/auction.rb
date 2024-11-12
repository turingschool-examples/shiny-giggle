class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        @items.map do |item|
            item.name
        end
    end

    def unpopular_items
        unpopular = []
        @items.each do |item|
            if item.bids == {}
                unpopular << item
            end
        end
        unpopular
    end

    def potential_revenue
        revenue = 0
        @items.each do |item|
            high_bid = item.current_high_bid
            if high_bid != nil
                revenue += high_bid
            end
        end
        revenue
    end

    def bidders
        bidder_names = []
        @items.each do |item|
            item.bids.each do |name|
                if bidder_names.include?(name[0].name)
                    next
                else
                    bidder_names << name[0].name
                end
            end
        end
        bidder_names
    end

    def bidder_info
        bidder_info = Hash.new do |bidder_info, attendee| 
            bidder_info[attendee] = { budget: attendee.budget, items: [] }
        end
        @items.each do |item|
          item.bids.each_key do |attendee|
            bidder_info[attendee][:items] << item
          end
        end
        # require 'pry'; binding.pry
        bidder_info
    end
end