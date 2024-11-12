require './lib/item'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
    end

    it 'exists' do
        expect(@item1).to be_a(Item)
    end

    it 'has attributes' do
        expect(@item1.name).to eq("Chalkware Piggy Bank")
        expect(@item2.name).to eq("Bamboo Picture Frame")
    end

    it 'will not add bid if bidding is closed' do
        attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @item1.add_bid(attendee1, 22)
        expect(@item1.bids).to eq({attendee1 => 22})

        @item1.close_bidding

        attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @item1.add_bid(attendee2, 20)
        expect(@item1.bids).to eq({attendee1 => 22}) #shows it cant be added due to bidding closed
    end
end