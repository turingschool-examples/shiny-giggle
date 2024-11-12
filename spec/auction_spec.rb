require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
    before(:each) do 
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @auction = Auction.new
    end

    describe "#initialize" do
        it 'exists' do 
            expect(@auction).to be_a(Auction)
        end

        it 'has attributes' do
            expect(@auction.items).to eq([])
        end
    end

    describe "#add_item" do
        it 'add_item' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)

            expect(@auction.items).to eq([@item1, @item2])
        end
    end

    describe "#item_names" do
        it 'item_names' do 
            @auction.add_item(@item1)
            @auction.add_item(@item2)

            expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
        end
    end

    describe "#unpopular_items" do
        it 'returns a list of items with no bids' do
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(item3)
            @auction.add_item(item4)
            @auction.add_item(item5)
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            expect(@auction.unpopular_items).to eq([@item2, item3, item5])
            item3.add_bid(attendee2, 15)
            expect(@auction.unpopular_items).to eq([@item2, item5])
        end
    end

    describe "#potential_revenue" do
        it 'returns the sum of each items highest bid' do
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(item3)
            @auction.add_item(item4)
            @auction.add_item(item5)
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)
            expect(@auction.potential_revenue).to eq(87)
        end
    end

    describe "#bidders" do
        it 'returns a list of bidders name in an array with string values' do
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(item3)
            @auction.add_item(item4)
            @auction.add_item(item5)
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)
            expect(@auction.bidders).to eq(["Bob", "Megan", "Mike"])
        end
    end

    describe "#bidder_info" do
        it 'returns a hash value of attendes objects as keys with nested hash values of their budget and items bid on' do
            item3 = Item.new('Homemade Chocolate Chip Cookies')
            item4 = Item.new('2 Days Dogsitting')
            item5 = Item.new('Forever Stamps')
            attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
            attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
            attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(item3)
            @auction.add_item(item4)
            @auction.add_item(item5)
            @item1.add_bid(attendee2, 20)
            @item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)

            expected = { 
                attendee1 => {
                    :budget => 50,
                    :items => [@item1]
                },
                attendee2 => {
                    :budget => 75,
                    :items => [@item1, item3]
                },
                attendee3 => {
                    :budget => 100,
                    :items => [item4]
                }
            }

            expect(@auction.bidder_info).to eq(expected)
        end
    end

end