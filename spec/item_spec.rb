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
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    it '#bids' do 
        expect(@item1.bids).to eq({})
    end

    it '#add_bid' do 
        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})

        @item1.add_bid(attendee2, 20)
        @item1.add_bid(attendee1, 22)

        expect(@item1.bids).to eq({attendee2 => 20, attendee1 => 22})
    end

    it '#current_high_bid' do 
        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        
        @item1.add_bid(attendee2, 20)
        @item1.add_bid(attendee1, 22)

        expect(@item1.current_high_bid).to eq(22)
    end
end