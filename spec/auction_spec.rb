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

    # Iteration 2

    describe "#unpopular/revenue" do
        before(:each) do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)
        end

        describe "#unpopular_items" do
            it 'can return a list of unpopular items (no bids)' do
                @item1.add_bid(@attendee2, 20)
                @item1.add_bid(@attendee1, 22)
                @item4.add_bid(@attendee3, 50)

                expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

                @item3.add_bid(@attendee2, 15)

                expect(@auction.unpopular_items).to eq([@item2, @item5])
            end
        end

        describe "#potential_revenue" do
            it 'can calculate the auctions potential revenue' do
                @item1.add_bid(@attendee2, 20) 
                @item1.add_bid(@attendee1, 22) # Will only count highest bid
                @item4.add_bid(@attendee3, 50)
                @item3.add_bid(@attendee2, 15)

                expect(@auction.potential_revenue).to eq(87)
            end
        end
    end

    # Iteration 3
    describe "#bidders/bidder_info" do
        before(:each) do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20) 
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            @item2.add_bid(@attendee1, 28)
        end

        describe "#bidders" do
            it 'can return an Array of bidders names' do
                expect(@auction.bidders).to eq(["Bob", "Megan", "Mike"])
            end

            describe "#list_bidder_objects" do
                it 'can return a list of attendee objects that bid' do
                    expect(@auction.list_bidder_objects).to eq([@attendee2, @attendee1, @attendee3])
                end
            end
        end

        describe "#bidder_info" do
            it 'can return a hash of bidders info' do
                expect(@auction.bidder_info).to eq({
                    @attendee1 => {
                        budget: 50,
                        items: [@item1, @item2]
                    },
                    @attendee2 => {
                        budget: 75,
                        items: [@item1, @item3]
                    },
                    @attendee3 => {
                        budget: 100,
                        items: [@item4]
                    }
                })
            end
        end
    end

    # Iteration 4

    # describe "#date" do
    #     it 'can return the date of the auction' do
    #         test_date = double("any date")

    #         allow(test_date).to receive(:date).and_return("24/02/2020")
    #         expect(@auction.date).to eq("24/02/2020")
    #     end
    # end

    describe "#close_auction" do
        before(:each) do
            @auction.add_item(@item1)
            @auction.add_item(@item2)
            @auction.add_item(@item3)
            @auction.add_item(@item4)
            @auction.add_item(@item5)

            @item1.add_bid(@attendee2, 20) 
            @item1.add_bid(@attendee1, 22)
            @item4.add_bid(@attendee3, 50)
            @item3.add_bid(@attendee2, 15)
            @item2.add_bid(@attendee1, 28)
        end

        it 'can close bidding on all items' do
            @auction.close_auction

            expect(@item1.closed).to eq true
            expect(@item2.closed).to eq true
            expect(@item3.closed).to eq true
            expect(@item4.closed).to eq true
            expect(@item5.closed).to eq true
        end

        it 'can return a hash of sold items' do
            expect(@auction.close_auction).to eq({
                @item1 => @attendee1,
                @item2 => @attendee1,
                @item3 => @attendee2,
                @item4 => @attendee3,
                @item5 => 'Not Sold'
            })
        end

        it 'can only sell items if an attendee can afford the bid' do
            @item5.add_bid(@attendee1, 15)

            expect(@auction.close_auction).to eq({
                @item1 => @attendee1,
                @item2 => @attendee1,
                @item3 => @attendee2,
                @item4 => @attendee3,
                @item5 => 'Not Sold'
            })
        end

        # helper method to determine if an attendee can afford the bid
        describe "#can_afford" do
            expect(@auction.can_afford(@item2, 28)).to be true
        
            @item5.add_bid(@attendee1, 15)
            expect(@auction.can_afford(@item5, 15)).to be false
        end
    end
end