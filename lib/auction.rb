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
        no_bid = []
        @items.each do |item|
           if item.bids.empty?
            no_bid << item
           end
        end
        no_bid
    end

    def potential_revenue
        revenue = 0
        @items.each do |item|
            if !item.bids.empty?
                revenue += item.current_high_bid
            end
        end
        revenue
    end

    def bidders
        bidder_names = []
        @items.each do |item|
            item.bids.each do |attendee, bid|
                bidder_names << attendee.name
            end
        end
        bidder_names.uniq
    end

    def bidder_info
        info_hash = {}

        @items.each do |item|
            item.bids.each do |attendee, bid|
                info_hash[attendee] ||= {:budget => attendee.budget, :items => []}
                info_hash[attendee][:items] << item
            end
        end
        info_hash
    end

    def close_auction
        winners = {}
        bid = 0

        @items.each do |item|
            item.bids.each do |attendee, bid|
                winners[attendee] ||= []
                if bid == item.current_high_bid
                    winners[attendee] << item
                end
            end
        end
        winners
    end
end