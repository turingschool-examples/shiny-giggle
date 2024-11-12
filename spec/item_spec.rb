require './lib/item'
require './spec/spec_helper'

RSpec.describe Item do 
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

    describe 'behaviors' do
        it 'adds bids' do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)

            expect(@item1.bids.count).to eq 2
            expect(@item1.bids).to eq( {@attendee2 => 20, @attendee1 => 22} )
        end

        it 'lists the current high bid' do
            expect(@item1.current_high_bid).to eq 22
        end
    end
end