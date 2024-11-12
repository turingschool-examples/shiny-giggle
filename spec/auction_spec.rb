require 'spec_helper'


RSpec.describe Auction do
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
        expect(@auction).to be_a(Auction)
    end

    it 'has attributes' do
        expect(@auction.items).to eq([])
        #binding.pry
        expect(@auction.date).to eq(Date.today)
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

    describe 'unpopular_items' do
        it "returns all the items at the auction that have no bids" do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            expect(@auction.unpopular_items).to be_a(Array)
            expect(@auction.unpopular_items).to include(@item2)
            expect(@auction.unpopular_items).to include(@item5)
            expect(@auction.unpopular_items).to include(@item3)
            @item3.add_bid(@attendee2, 15)
            expect(@auction.unpopular_items).not_to include(@item3)
        end
    end

    describe 'potential_revenue' do
        it "adds all the highest bids of all items with bids and returns sum" do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            expect(@auction.potential_revenue).to eq(87)
        end
    end

    describe 'bidders' do
        it "returns an array of the names of all the bidders at the auction" do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            #binding.pry
            expect(@auction.bidders).to be_an(Array)
            expect(@auction.bidders).to include('Megan')
            expect(@auction.bidders).to include('Bob')
            expect(@auction.bidders).to eq(["Bob", "Megan", "Mike"])
        end
    end

    describe 'bidder_info' do
        it "displays a hash of attendees at the auction and then a hash for that attendee that holds their budget and their items" do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            #binding.pry
            expect(@auction.bidder_info).to be_a(Hash)
            expect(@auction.bidder_info).to include(@attendee1)
            expect(@auction.bidder_info).to include(@attendee2)
            expect(@auction.bidder_info).to include(@attendee3)
            expect(@auction.bidder_info[@attendee1]).to be_a(Hash)
            expect(@auction.bidder_info[@attendee1]).to include(:budget)
            expect(@auction.bidder_info[@attendee1]).to include(:items)
            expect(@auction.bidder_info[@attendee2][:items]).to include(@item1)
            expect(@auction.bidder_info[@attendee2][:budget]).to eq(75)
            expect(@auction.bidder_info[@attendee3][:items]).to include(@item4)
            expect(@auction.bidder_info[@attendee3][:budget]).to eq(100)
        end
    end
    #didnt have enough time to start this
    # describe 'close_auction' do
    #     it "closes the bidding for the items at the auction and sells them to the attendee that has the highest bid as long as their bids dosent exceed thier budget" do
            
    #     end
    # end
end
