require './lib/item'
require './lib/attendee'
require './lib/auction'
require 'date'

RSpec.describe Auction do
    before(:each) do 
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @item3 = Item.new('Homemade Chocolate Chip Cookies')
        @item4 = Item.new('2 Days Dogsitting')
        @item5 = Item.new('Forever Stamps')
        @auction = Auction.new
        @attendee1 = Attendee.new({ name: 'Megan', budget: '$50' })
        @attendee2 = Attendee.new({ name: 'Bob', budget: '$75' })
        @attendee3 = Attendee.new({ name: 'Mike', budget: '$100' })
    end

    it 'exists' do 
        expect(@auction).to be_a(Auction)
    end

    it 'has empty attributes' do
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

        expect(@auction.item_names).to eq([
            "Chalkware Piggy Bank", 
            "Bamboo Picture Frame",       
        ])
    end

    it 'identifies (unpopular_items) - items with no bids' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        @item1.add_bid(@attendee1, 20)
            expect(@auction.unpopular_items).to eq([@item2, @item3, @item4, @item5])

        @item2.add_bid(@attendee2, 15)
            expect(@auction.unpopular_items).to eq([@item3, @item4, @item5])
    end

    it 'calculates (potential revenue) - highest bids' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
            expect(@auction.unpopular_items).to eq([@item2, @item3, @item4, @item5])

        @item4.add_bid(@attendee3, 50)
            expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

        @item3.add_bid(@attendee2, 15)
            expect(@auction.unpopular_items).to eq([@item2, @item5])

        expect(@auction.potential_revenue).to eq(87)  # 22 (item1 - highest bid) + 15 (item3) + 50 (item4)
    end

    it 'returns array of bidders names as string' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)

        @item1.add_bid(@attendee1, 20)
        @item1.add_bid(@attendee2, 30)
        @item2.add_bid(@attendee3, 15)

        expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it 'returns bidder_info with hash value' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
    
        @item1.add_bid(@attendee1, 20)
        @item1.add_bid(@attendee2, 30)
        @item2.add_bid(@attendee2, 25)
        @item3.add_bid(@attendee3, 15)
    
        expected_info = {
            @attendee1 => { budget: 50, items: [@item1] },
            @attendee2 => { budget: 75, items: [@item1, @item2] },
            @attendee3 => { budget: 100, items: [@item3] }
        }
    
        expect(@auction.bidder_info).to eq(expected_info)
    end

    it 'has date for auction' do
        allow(Date).to receive(:today).and_return(Date.new(2020, 2, 24))

        auction_date = Auction.new
        expect(auction_date.date).to eq("24/02/2020")
    end

end