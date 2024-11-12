require 'date'

class Auction
    attr_reader :items, :date

    def initialize
        @items = []
        @date = Date.today
    end

    def date #was going to get started on the date method but dont feel confidanet in my skills with stubs so dont really know how to do this
        @date
    end

    def add_item(item)
        @items << item
    end

    def item_names
        @items.map(&:name)
    end

    def unpopular_items 
        unpopular = []
        @items.each do |item|
          if item.bids.empty?
            unpopular << item
          end
        end
        unpopular
    end

    def potential_revenue
        total_revenue = 0

        @items.each do |item|
            highest_bid = item.current_high_bid
            total_revenue += highest_bid if highest_bid
        end

        total_revenue
    end

    def bidders
        bidders_names = []

        @items.each do |item|
            item.bids.each do |attendee, _|
                bidders_names << attendee.name
            end
        end

        bidders_names.uniq
    end

    def bidder_info
        info = {}

        @items.each do |item|
            item.bids.each do |attendee, _|
              if info[attendee] == nil
                info[attendee] = { :budget => attendee.budget, :items => [] }
              end
              info[attendee][:items] << item
            end
        end
        info
    end
end