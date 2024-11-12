require './spec/spec_helper'

RSpec.describe Auction do
    describe 'instantiation' do
        it 'exists' do 
            expect(@auction).to be_a(Auction)
        end

        it 'holds an array of items' do
            expect(@auction.items).to be_an Array
        end

        it 'holds an array of bidders' do 
            expect(@auction.bidders).to be_an Array
        end
    end

    describe 'behaviors' do
        it 'can add items' do
            expect(@auction.items).to eq([@item1, @item2, @item3, @item4, @item5])
            expect(@auction.items.count).to eq 5
        end

        it ' can list items in the auction' do 
            expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame", "Homemade Chocolate Chip Cookies", "2 Days Dogsitting", "Forever Stamps"])
        end

        it 'returns items with 0 bids' do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)

            expect(@auction.unpopular_items).to eq([@item2, @item3, @item4, @item5])

            @item4.add_bid(@attendee3, 50)

            expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

            @item3.add_bid(@attendee2, 15)

            expect(@auction.unpopular_items).to eq([@item2, @item5])
        end

        it 'returns the sum of highest bids' do
            expect(@auction.potential_revenue).to eq 87
        end

        it 'can add bidders' do
            @auction.add_attendee(@attendee1)
            @auction.add_attendee(@attendee2)
            @auction.add_attendee(@attendee3)

            expect(@auction.bidders.count).to eq 3
            expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
        end

        it 'can create a hash of bidder information' do
            @auction.add_attendee(@attendee1)
            @auction.add_attendee(@attendee2)
            @auction.add_attendee(@attendee3)

            expect(@auction.bidder_info).to be_a Hash
            expect(@auction.bidder_info.keys).to eq([@attendee1, @attendee2, @attendee3])
        end
    end

end