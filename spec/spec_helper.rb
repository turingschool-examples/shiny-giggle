require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'rspec'
require 'pry'

RSpec.configure do |config|
  config.before(:all) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')

    @attendee1 = Attendee.new({ name: 'Megan', budget: '$50' })
    @attendee2 = Attendee.new({ name: 'Bob', budget: '$75' })
    @attendee3 = Attendee.new({ name: 'Mike', budget: '$100' })

    @auction = Auction.new
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
  end
end
