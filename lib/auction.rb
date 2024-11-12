class Auction
    attr_reader :items
   
    def initialize
        @items = []
    end

    def add_item(item)
        @items << item
    end

    def item_names
        proper_names = []
        @items.each do |item|
          string_items =item.name.to_s 
          proper_names << string_items
        end
        proper_names
    end

    def unpopular_items #need to filter and only put the items with no bid,  coniditona?
        items_no_bid = []

      @items.each do |item|
        if item.bids.empty?
          items_no_bid << item
        end
      end
      items_no_bid
    end

    def potential_revenue #need to return the sum of each items highest bid 
        collector = []    #need to find the highest bid for the item, add only the highest bid(conditional?)
      @items.each do |item|
        if largest_bid = item.bids.values.max #getting nil in teh array as well(coniditonal)
          collector << largest_bid
        end
      end
      collector.sum #getting an array of highest , need to add them together
    end

    def bidders #need to return an array with the names of the bidders as strings
      bidders_names_strings = []

      @items.each do |item|
        item.bids.keys.each do |key|
          bidders_name = key.name             #im getting duplicates need to ensure that noe duplicate are oin array
          if !bidders_names_strings.include?(bidders_name)
            bidders_names_strings << bidders_name
          end
        end
      end
      bidders_names_strings
    end

    def bidder_info #need hash to start
                        #nned to access the keys, iterate mutliple times just like bidders method?
        info_for_bidders = {}

        @items.each do |item|
          item.bids.keys.each do|attendee| 
                                                        
            if !info_for_bidders.include?(attendee)
            info_for_bidders[attendee] ||= {}                                    #need a another hash in it, #need the correct format in the  hash
              info_for_bidders[attendee][:budget] = attendee.budget                
              info_for_bidders[attendee][:items] = []
            end            
            info_for_bidders[items:]  << item                
          end
        end
        info_for_bidders
    end
      ### i think i am close but i still got two of the methods fro iteration 3 , would still have liked to finsih this
end