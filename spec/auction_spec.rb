require './lib/item'
require './lib/auction'
require './lib/attendee'


RSpec.describe Auction do
    before(:all) do 
        @auction = Auction.new
    end

    describe 'instantiation' do
        it 'exists' do 
            expect(@auction).to be_a(Auction)
        end

        it 'starts with an empty array of items' do
            expect(@auction.items).to eq([])
        end
    end

    describe 'behaviors' do
        before(:each) do
            @item1 = Item.new('Chalkware Piggy Bank')
            @item2 = Item.new('Bamboo Picture Frame')
            @item3 = Item.new('Homemade Chocolate Chip Cookies')
            @item4 = Item.new('2 Days Dogsitting')
            @item5 = Item.new('Forever Stamps')
            
            @attendee1 = Attendee.new({ name: 'Megan', budget: '$50' })
            @attendee2 = Attendee.new({ name: 'Bob', budget: '$75' })
            @attendee3 = Attendee.new({ name: 'Mike', budget: '$100' })
            
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
        end

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

            # expect(@auction.unpopular_items).to eq([@item2, @item3, @item4, @item5])
            expect(@auction.unpopular_items.count).to eq 4
        end
    end

end