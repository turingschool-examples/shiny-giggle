require './lib/item'
require './lib/auction'
require './lib/attendee'

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

    it 'can return item_names' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)

        expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end

    it 'can add a bid to an item' do
        @auction.add_item(@item1)
        
        @auction.place_bid(@item1, @attendee2, 20)
        @auction.place_bid(@item1, @attendee1, 22)
    
        expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end

    it 'can return which items are unpopular based on their bidding status' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
    
        @auction.place_bid(@item1, @attendee2, 20)
        @auction.place_bid(@item1, @attendee1, 22)
        @auction.place_bid(@item4, @attendee3, 50)

        expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
    end
end
