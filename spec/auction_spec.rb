require './lib/item'
require './lib/auction'
require 'date'

RSpec.describe Auction do
    before(:each) do 
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @item3 = Item.new('Homemade Chocolate Chip Cookies')
        @item4 = Item.new('2 Days Dogsitting')
        @item5 = Item.new('Forever Stamps')
        allow(Date).to receive(:today).and_return(Date.new(2020, 02, 24))
        @auction = Auction.new
        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    end

    it 'exists' do 
        expect(@auction).to be_a(Auction)
    end

    it 'has attributes' do
        expect(@auction.items).to eq([])
        expect(@auction.date).to eq('24/02/2020')
    end

    it 'add_item' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)

        expect(@auction.items).to eq([@item1, @item2])
    end

    it 'item_names' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)

        expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end

    describe '#unpopular_items' do
        it 'returns all items that have no bids' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            expect(@auction.unpopular_items).to eq([@item1, @item2, @item3, @item4, @item5])

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
        end
    end

    describe '#potential_revenue' do
        it 'returns the sum of each items highest bid' do
            @auction.add_item(@item1)
            @auction.add_item(@item3)
            @auction.add_item(@item4)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.potential_revenue).to eq(87)
        end
    end

    describe '#bidders' do
        it 'returns an array of all the current bidders names' do
            @auction.add_item(@item1)
            @auction.add_item(@item3)
            @auction.add_item(@item4)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.bidders).to contain_exactly('Megan', 'Bob', 'Mike')
        end
    end

    describe '#bidder_objects' do
        it 'returns an array of all attendee objects that have a bid placed' do
            @auction.add_item(@item1)
            @auction.add_item(@item3)
            @auction.add_item(@item4)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.bidder_objects).to contain_exactly(@attendee1, @attendee2, @attendee3)
        end
    end

    describe '#bidder_info' do
        it 'returns a nested hash of bidder information' do
            @auction.add_item(@item1)
            @auction.add_item(@item3)
            @auction.add_item(@item4)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            bidder_info = @auction.bidder_info

            expect(bidder_info).to be_a(Hash)
            bidder_info.each do |attendee, info|
                expect(attendee).to be_a(Attendee)
                expect(info).to be_a(Hash)

                expect(info.keys).to contain_exactly(:budget, :items)
                expect(info[:budget]).to eq(attendee.budget)
                expect(info[:items]).to be_an(Array)

                info[:items].each do |item|
                    expect(item).to be_an(Item)
                    bids = item.bids
                    bidders = bids.keys
                    expect(bidders.include?(attendee)).to be true
                end
            end
        end
    end
end