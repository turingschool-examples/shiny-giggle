require './lib/item'

RSpec.describe Item do 
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @item3 = Item.new('Homemade Chocolate Chip Cookies')
        @item4 = Item.new('2 Days Dogsitting')
        @item5 = Item.new('Forever Stamps')
    end

    describe 'instantiation' do
        it 'exists' do
            expect(@item1).to be_a(Item)
            expect(@item2).to be_a(Item)
            expect(@item3).to be_a(Item)
            expect(@item4).to be_a(Item)
            expect(@item5).to be_a(Item)
        end

        it 'has name attributes' do
            expect(@item1.name).to eq("Chalkware Piggy Bank")
            expect(@item2.name).to eq("Bamboo Picture Frame")
            expect(@item3.name).to eq('Homemade Chocolate Chip Cookies')
            expect(@item4.name).to eq('2 Days Dogsitting')
            expect(@item5.name).to eq('Forever Stamps')
        end

        it 'starts with an empty hash of bids' do
        expect(@item1.bids).to eq({})
        expect(@item2.bids).to eq({})
        expect(@item3.bids).to eq({})
        expect(@item4.bids).to eq({})
        expect(@item5.bids).to eq({})
        end
    end
end