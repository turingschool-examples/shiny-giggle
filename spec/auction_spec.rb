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

    it 'add_item - only items added show in array' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)

        expect(@auction.items).to eq([@item1, @item2, @item3, @item4])
    end

    it 'item_names - all items can be added' do 
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)

        expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame", "Homemade Chocolate Chip Cookies", "2 Days Dogsitting", "Forever Stamps"])
    end


    it 'unpopular_items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)

      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end

    it 'potential_revenue' do
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

    it 'returns all bidders' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@auction.bidders_data).to eq([@attendee2, @attendee1])
    end

    it 'returns all bidders names as strings' do
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@auction.bidders).to eq(['Bob', 'Megan'])
    end
end