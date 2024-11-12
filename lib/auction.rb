class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items.push(item)
  end

  def item_names
    @items.map(&:name)
  end

  # Returns an array of items with no bids
  def unpopular_items
    @items.select { |item| item.bids.empty? }
  end

  # Calculates the total of the highest bids across all items
  def potential_revenue
    @items.sum { |item| item.current_high_bid.to_i }
  end

  def bidder_info
    info = {}
    @items.each do |item|
      item.bids.each do |attendee, _|
        info[attendee] ||= { budget: attendee.budget, items: [] }
        info[attendee][:items] << item
        end
    end
    info
end
