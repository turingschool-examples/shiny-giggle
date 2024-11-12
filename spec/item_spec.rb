require './lib/item'
require './lib/attendee'

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

    # Iteration 2
    
    it 'has a list of bids defaulted to an empty hash' do
        expect(@item1.bids).to eq({})
    end

    it 'can be bid on' do
        expect(@item1.bids).to eq({})

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@item1.bids).to eq({
            @attendee2 => 20,
            @attendee1 => 22
        })
    end

    it 'can determine the current highest bid' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        
        expect(@item1.current_high_bid).to eq(22)
    end

    describe "#close_bidding" do
        before(:each) do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
        end

        it 'has a closed attribute defaulted to false' do
            expect(@item1.closed).to be false
        end

        it 'can close bidding' do
            expect(@item1.close_bidding).to eq("Closed!")
            expect(@item1.closed).to be true
        end

        it 'can no longer accept new bids after closed' do
            @item1.close_bidding

            expect(@item1.add_bid(@attendee3, 24)).to eq("Bidding Closed!")
        end
    end
end