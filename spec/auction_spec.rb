require 'pry'
require './lib/item'
require './lib/attendee'
require './lib/auction'

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

    it '#unpopular_items' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        @item4.add_bid(@attendee3, 50)
        @item3.add_bid(@attendee2, 15)

        expect(@auction.unpopular_items).to eq([@item2, @item5])
    end

    it '#potential_revenue' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        @item4.add_bid(@attendee3, 50)
        @item3.add_bid(@attendee2, 15)

        expect(@auction.potential_revenues).to eq(87)
    end

    it '#auction_bidders' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        attendee4 = Attendee.new({name: 'Ash', budget: '$75'})

        @item1.add_bid(@attendee2, 20)
        # @item1.add_bid(@attendee1, 22)
        @item4.add_bid(@attendee3, 50)
        @item4.add_bid(attendee4, 11)
        @item3.add_bid(@attendee2, 15)

        expect(@auction.auction_bidders).to eq(["Bob", "Mike", "Ash"])
    end

    it '#bidder_info' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        attendee4 = Attendee.new({name: 'Ash', budget: '$70'})

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        @item3.add_bid(@attendee2, 15)

        # returns --> {attendee2: {name: {budget: 75, items: [items bid on]}
        expect(@auction.bidder_info).to eq({@attendee2 => {budget: 75, items: [@item1, @item3]}, @attendee1 => {budget: 50, items: [@item1]}})

        @item2.add_bid(@attendee3, 50)
        @item4.add_bid(attendee4, 11)

        expected_2 = {@attendee2 => {budget: 75, items: [@item1, @item3]}, @attendee1 => {budget: 50, items: [@item1]}, @attendee3 => {budget: 100, items: [@item2]}, attendee4 => {budget: 70, items: [@item4]}}
    
        expect(@auction.bidder_info).to eq(expected_2)
    end

    xit '#close_bidding' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        @item1.add_bid(@attendee2, 20)
        @item4.add_bid(@attendee3, 50)
        @item4.add_bid(attendee4, 11)
        @item3.add_bid(@attendee2, 15)

        # @auction.close_bidding(@item4)
        expect(@auction.close_bidding(@item4)).to eq("Bidding on '2 Days Dogsitting' is officially closed!")
    end
end