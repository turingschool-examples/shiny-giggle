require 'date'

class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item 
    end

    def item_names
        @items.map(&:name)
    end

    def unpopular_items
        @items.select { |item| item.bids.empty? }
    end

    def potential_revenue
        @items.sum { |item| item.current_highest_bid.to_i }
    end

    def bidders
        @items.map { |item| item.bids.keys.map(&:name) }.flatten.uniq
    end

    def bidder_info
        info = Hash.new { |hash, key| hash[key] = { budget: key.budget, items: [] } }
    
        @items.each do |item|
          item.bids.each_key do |attendee|
                info[attendee][:items] << item
          end
        end
        info
    end

    def date
        Date.today.strftime("%d/%m/%Y")
    end
end