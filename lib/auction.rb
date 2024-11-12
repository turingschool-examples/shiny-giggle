class Auction
    attr_reader :items, :bidding_open

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

    def auction_bidders
        bidder_names = []
        @items.each do |item| #go thru each item
            item.bids.each do |bidder, _| #go thru bid, focus on key (bidder name)       
            if !bidder_names.include?(bidder.name) #protect for duplicates
                bidder_names << bidder.name 
            end
          end
        end
        bidder_names
    end


    def bidder_info
        # return hash -- {attendee object => {budget => integer, items =>[items bid on]}
        bidder_summary = {}
        @items.each do |item| #go thru each item
            # bidders = []
            item.bids.each do |bidder, _| #go thru bid, focus on key (bidder name)  
                if bidder_summary.keys.include?(bidder) #see if that bidder/attendee already exists as a key
                    bidder_summary[bidder][:items] << item
                else
                    bidder_summary[bidder] = {:budget => bidder.budget, :items => [item]}
                end
            end
        end
        
        bidder_summary
    end

    # def close_bidding(item)

    #     #should update the item so that it will not accept additional bids
    #     #Return value of your choice; ensure it follows the spec above such that 
    #     #closing the bidding on an item makes it so the item will no longer accept new bids.
    # end
end