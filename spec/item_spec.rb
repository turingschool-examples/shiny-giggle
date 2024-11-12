require './lib/item'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    it 'can initialize bids with empty hash' do
        expect(@item1.bids).to eq({})
    end

    it 'can add bids to return highest bids' do
        @item1.add_bid(@attendee1, 20)
        @item1.add_bid(@attendee1, 22)

            expect(@item1.bids).to eq({ @attendee1 => 20, @attendee2 => 22})
            expect(@item1.current_high_bid).to eq(22)
    end
    it 'stops accepting new bids after bidding is closed' do
        @item1.add_bid(@attendee1, 20)
        expect(@item1.bids).to eq({ @attendee1 => 20 })

        @item1.closed_bidding
        @item1.add_bid(@attendee2, 24)  # This bid shouldnt be added

        expect(@item1.bids).to eq({ @attendee1 => 20 })
    end
end