require './lib/item'
require './lib/attendee'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')

        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
        expect(@item1.bids).to eq({})
    end

    it 'can add a bid to an item' do
        @item1.add_bid(@attendee1, 20)
        @item1.add_bid(@attendee2, 22)

        expect(@item1.bids).to eq({@attendee1 => 20, @attendee2 => 22})
    end

    it 'can return the highest current bid' do
        @item1.add_bid(@attendee1, 20)
        @item1.add_bid(@attendee2, 22)

        expect(@item1.current_high_bid).to eq(22)
    end
end