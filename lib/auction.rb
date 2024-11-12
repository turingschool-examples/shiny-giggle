class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        items.map do |item|
            item.name
        end
    end

    def unpopular_items
      unwanted = []
      @items.each do |item|
       if item.bids == {}
         unwanted << item
       end
      end
      unwanted
    end

    def potential_revenue
        # possible = []
        total = 0
        items.each do |item|
            total += item.total_high_bids
        #   item.bids.each do |bid|
        #     bid.each do |k, v|
        #       possible << v
        #     end
        #   end
        end
        total
    end


    def bidders_data
        all_bidders = []
        @items.each do |item|
          item.bids.each do |bid|
            bid.each do |k, v|
              all_bidders << k
            end
          end
        end
        all_bidders
    end

    def bidders
      names = []  
      bidders_data.each do |bidder|
        names << bidder.name
      end
      names
    end
end