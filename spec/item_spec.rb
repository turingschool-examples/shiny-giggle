require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @item3 = Item.new('Homemade Chocolate Chip Cookies')
        @item4 = Item.new('2 Days Dogsitting')
        @item5 = Item.new('Forever Stamps')
        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
        @auction = Auction.new
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    it 'defults empty hash for item bids' do
        @auction.add_item(@item1)

        expect(@item1.bids).to eq({})
    end

    it 'add_bid to item hash' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
# require 'pry'; binding.pry
        expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end

    it 'current_high_bid returns highest bid placed on item' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@item1.current_high_bid).to eq(22)
    end

    it 'bidding closes' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})

        @item1.close_bidding

        expect(@item1.add_bid(@attendee3, 20)).to eq("Bidding closed, please choose another item.")
    end
end