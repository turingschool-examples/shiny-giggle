require 'spec_helper'
require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @auction = Auction.new

    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)

    @attendee1 = Attendee.new({ name: 'Megan', budget: '$50' })
    @attendee2 = Attendee.new({ name: 'Bob', budget: '$75' })
    @attendee3 = Attendee.new({ name: 'Mike', budget: '$100' })
  end

  it 'exists and has attributes' do
    expect(@auction).to be_a(Auction)
    expect(@auction.items).to eq([@item1, @item2, @item3, @item4, @item5])
  end

  it 'can add items to the auction' do
    expect(@auction.items).to eq([@item1, @item2, @item3, @item4, @item5])
  end

  it 'can identify unpopular items (items with no bids)' do
    # Add bids to some items
    @item1.add_bid(@attendee1, 20)
    @item4.add_bid(@attendee3, 50)

    # Verify items with no bids are identified as unpopular
    expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
  end

  it 'updates unpopular items when bids are added' do
    # Add bids to some items
    @item1.add_bid(@attendee1, 20)
    @item4.add_bid(@attendee3, 50)

    expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

    # Add a bid to another item
    @item3.add_bid(@attendee2, 15)

    # Verify the updated list of unpopular items
    expect(@auction.unpopular_items).to eq([@item2, @item5])
  end

  it 'can calculate potential revenue' do
    # Add multiple bids to items
    @item1.add_bid(@attendee1, 20)
    @item1.add_bid(@attendee2, 25)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    # Verify potential revenue as the sum of highest bids
    expect(@auction.potential_revenue).to eq(90)
  end

  it 'handles potential revenue with no bids' do
    # Verify potential revenue is zero when no bids are added
    expect(@auction.potential_revenue).to eq(0)
  end

  it 'handles edge cases for unpopular items' do
    # Verify all items are initially unpopular
    expect(@auction.unpopular_items).to eq([@item1, @item2, @item3, @item4, @item5])

    # Add bids to all items
    @item1.add_bid(@attendee1, 20)
    @item2.add_bid(@attendee2, 15)
    @item3.add_bid(@attendee3, 30)
    @item4.add_bid(@attendee1, 40)
    @item5.add_bid(@attendee2, 50)

    # Verify there are no unpopular items after all have bids
    expect(@auction.unpopular_items).to eq([])
  end

  it 'can return an array of bidders names' do
    # Add bids to items
    @item1.add_bid(@attendee1, 20)
    @item1.add_bid(@attendee2, 25)
    @item3.add_bid(@attendee3, 15)

    # Verify the list of bidder names
    expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
  end

  it 'can return bidder info' do
    # Add bids to items
    @item1.add_bid(@attendee1, 20)
    @item1.add_bid(@attendee2, 25)
    @item3.add_bid(@attendee2, 15)
    @item4.add_bid(@attendee3, 50)

    # Verify the bidder info hash
    expected = {
      @attendee1 => {
        :budget => 50,
        :items => [@item1]
      },
      @attendee2 => {
        :budget => 75,
        :items => [@item1, @item3]
      },
      @attendee3 => {
        :budget => 100,
        :items => [@item4]
      }
    }

    expect(@auction.bidder_info).to eq(expected)
  end
end