require 'spec_helper'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    describe 'add_bid' do
        it "adds an attendee and their bid to the item" do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            expect(@item1.bids).to be_a(Hash)
            expect(@item1.bids).to include(@attendee1)
            expect(@item1.bids).to include(@attendee2)
            @item1.close_bidding
            expect(@item1.add_bid(@attendee3, 20)).to eq("Bidding has been closed for this item")
        end
    end

    describe 'current_high_bid' do
        it "returns the highest bid of all atendees on that item" do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            expect(@item1.current_high_bid).to eq(22)
        end
    end

    describe 'close_bidding' do
        it "changes the bidding_closed attribute from false to true" do
            expect(@item1.bidding_closed).to eq(false)
            @item1.close_bidding
            expect(@item1.bidding_closed).to eq(true)
        end
    end
end