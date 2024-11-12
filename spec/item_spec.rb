require './lib/item'
require './lib/auction'
require './lib/attendee'

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
        @attendee4 = Attendee.new({name: 'Matt', budget: '$150'})

        @auction = Auction.new
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    describe '#bids' do
        it 'starts with an empty bids hash' do

            expect(@item1.bids).to eq({})
        end
    end

    describe '#bid_count' do
        it 'starts at 0' do

            expect(@item1.bid_count).to eq(0)
        end
    end

    describe '#add_bid(attendee, bid)' do
        it 'adds a bid to the bids hash with the attendee as the key and their bid as the value, and increases bid_count by 1' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)

            expected = {
                @attendee2 => 20,
                @attendee1 => 22
            }

            expect(@item1.bids).to eq(expected)
            expect(@item1.bid_count).to eq(2)
        end
    end

    describe '#current_high_bid' do
        it 'returns the highest bid for a specific item' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)

            expect(@item1.current_high_bid).to eq(22)
        end
    end

    describe '#close_bidding' do
        it 'makes it so items cannot be bid on more than 3 times' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee1, 22)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            expect(@item1.close_bidding).to eq("Bidding is closed for this item.")
            expect(@item3.close_bidding).to eq("This item is still accepting bids.")
            expect(@item4.close_bidding).to eq("This item is still accepting bids.")
            expect(@item2.close_bidding).to eq("This item is not up for auction.")
            expect(@item5.close_bidding).to eq("This item is not up for auction.")

            @item1.add_bid(@attendee1, 22)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee3, 50)

            expect(@item1.add_bid(@attendee4, 75)).to eq("This item is no longer accepting bids.")
        end
    end
end