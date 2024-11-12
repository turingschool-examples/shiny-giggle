require './lib/item'
require './lib/attendee'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
    end

    describe "#initialize" do
        it 'exists' do
            expect(@item1).to be_a(Item)
        end

        it 'has attributes' do
            expect(@item1.name).to eq("Chalkware Piggy Bank")
            expect(@item2.name).to eq("Bamboo Picture Frame")
        end
    end

    describe "#bids" do
        it 'keeps track of bids on an item' do
            expect(@item1.bids).to eq({})
        end
    end

    describe "#add_bid" do
        it 'allows attendees to place bids on an item' do
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            expect(@item1.bids).to eq({})
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            expect(@item1.bids).to eq({attendee2 => 20, attendee1 => 22})
        end
    end

    describe "#current_high_bid" do
        it 'returns the current highest bid of an item' do
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            expect(@item1.current_high_bid).to eq(22)
        end
    end

    describe "#close_bidding" do
        it 'confirms that if bidding on an item is closed, no more bids are accepted' do
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            expect(@item1.bids).to eq({})
            @item1.add_bid(attendee2, 20)
            @item1.close_bidding
            @item1.add_bid(attendee1, 22)
            expect(@item1.bids).to eq({attendee2 => 20})
        end
    end
end