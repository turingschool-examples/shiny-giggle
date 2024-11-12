class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name        # The name of the item being auctioned
    @bids = {}          # A hash to store bids where keys are attendees and values are bid amounts
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount # Add the attendee as a key and their bid amount as the value to the bids hash
  end
end
