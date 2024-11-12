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

    it 'can add_bid to the bids hash and return the hash' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        expect(@auction.items).to eq([@item1, @item2, @item3, @item4, @item5])
    end

    it 'can return unpopular_items - no bids' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        expect(@item1.bids).to eq({})

        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        @item4.add_bid(@attendee3, 50)

        expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

        @item3.add_bid(@attendee3, 50)

        expect(@auction.unpopular_items).to eq([@item2, @item5])
    end

    it 'can return unpopular_items - no bids' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        expect(@item1.bids).to eq({})

        @item1.add_bid(@attendee1, 22)
        @item1.add_bid(@attendee2, 20)
        @item4.add_bid(@attendee3, 50)
        
        expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it 'can return key of Attendee object pointing to a value of a Hash.
        Subhash key of :budget(symbol) => budget(integer)
                       :items => items the attendee has bid on(array)' do
        
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        expect(@item1.bids).to eq({})

        @item1.add_bid(@attendee1, 22)
        @item1.add_bid(@attendee2, 20)
        @item2.add_bid(@attendee2, 20)
        @item2.add_bid(@attendee3, 50)
        @item4.add_bid(@attendee3, 50)
        
        expect(@auction.bidder_info).to eq({
          @attendee1 => {:budget => 50, :items => [@item1]},
          @attendee2 => {:budget => 75, :items => [@item1, @item2]},
          @attendee3 => {:budget => 100, :items => [@item2, @item4]}
        })
    end

    it "can return date of aution in dd/mm/yyyy" do
        allow(Date).to receive(:today).and_return Date.new(2020, 2, 24)
        expect(@auction.date).to eq("24/02/2020")

        allow(Date).to receive(:today).and_return Date.new(1991, 8, 17)
        expect(@auction.date).to eq("17/08/1991")

        allow(Date).to receive(:today).and_return Date.new(1964, 11, 05)
        expect(@auction.date).to eq("05/11/1964")

        allow(Date).to receive(:today).and_return Date.new(2092, 2, 24)
        expect(@auction.date).to eq("24/02/2092")
    end
end