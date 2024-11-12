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
        @items.map do |item|
            item.name
        end
    end

    def unpopular_items
        unpopular = @items.select do |item|
            item.bids.empty?
        end
        unpopular
    end

    def potential_revenue
        revenue = 0
        @items.each do |item|
            if !unpopular_items.include?(item)
                revenue += item.current_high_bid
            end
        end
        revenue
    end

    def bidders
        bidders = list_bidder_objects
        
        return bidder_names = bidders.map do |bidder|
            bidder.name
        end
    end

    def bidder_info
        bidder_info = {}
        bidder_objects = list_bidder_objects

        bidder_objects.each do |bidder|
            @items.each do |item|
                if item.bids.keys.include?(bidder)
                    if !bidder_info.keys.include?(bidder)
                        bidder_info[bidder] =  {budget: bidder.budget,
                                                items: [item]}
                    else
                        bidder_info[bidder][:items] << item
                    end
                end
            end
        end
        bidder_info
    end

    # def date
    #     Date.today.to_s
    # end

   

    # Helper Method that returns an array of the attendee objects that bid
    def list_bidder_objects
        bidder_objects = []

        @items.each do |item|
            item_bidders = item.bids.keys

            item_bidders.each do |bidder|
                if !bidder_objects.include?(bidder)
                    bidder_objects << bidder
                end
            end
        end
        bidder_objects
    end

    def can_afford(bidder, bid)
        if bidder.budget >= bid
            bidder.spend(bid)
            true
        else
            false
        end
    end

end