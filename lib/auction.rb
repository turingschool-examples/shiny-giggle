class Auction
    attr_reader :items, :attendees, :bids

    def initialize
        @items = []
        @attendees = []
        @bids = []
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
    
    def bidders
        bidder_names = @items.flat_map do |item|
            item.bidders
        end
        bidder_names.uniq
    end
    
    def bidder_info
        @bidders.each_with_object({}) do |attendee, info|
          info[attendee] = {
            :budget => @attendee.budget,
            :items => @attendee.items
          }
        end
    end
end