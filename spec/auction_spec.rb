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

    it 'item_names' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)

        expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end

    describe '#unpopular_items' do
        it 'returns an array of the items with no bids' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)

            expected = [@item2, @item3, @item5]
            expect(@auction.unpopular_items).to eq(expected)

            @item3.add_bid(@attendee2, 15)

            expected = [@item2, @item5]
            expect(@auction.unpopular_items).to eq(expected)
        end
    end

    describe '#potential_revenue' do
        it 'returns the sum of each items highest bid' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.potential_revenue).to eq(87)
        end
    end

    describe '#bidders' do
        it 'returns an array of bidders names as strings' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item1.add_bid(@attendee2, 20)
            @item4.add_bid(@attendee3, 50)

            expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
        end
    end

    describe '#bidder_info' do
        it 'returns a hash with an attendee key and two hash values, one being the budget, and the other an array of items they bid on' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item1.add_bid(@attendee2, 20)
            @item4.add_bid(@attendee3, 50)

            expected = {
                @attendee1 => {
                    :budget => 50,
                    :items => [@item1]
                },
                @attendee2 => {
                    :budget => 75,
                    :items => [@item1, @item3]
                },
                @attendee3 => {
                    :budget => 100,
                    :items => [@item4]
                }
            }

            expect(@auction.bidder_info).to eq(expected)
        end
    end

    describe '#close_auction' do
        it 'returns a hash with each Item object as a key pointing to a value of the Attendee object who won the item' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
            
            @item1.add_bid(@attendee1, 22)
            @item3.add_bid(@attendee2, 15)
            @item1.add_bid(@attendee2, 20)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 5)
            @item5.add_bid(@attendee3, 20)

            expected = {
                @attendee1 => [@item1],
                @attendee2 => [@item3],
                @attendee3 => [@item4, @item5]
            }

            expect(@auction.close_auction).to eq(expected)
        end
    end
end