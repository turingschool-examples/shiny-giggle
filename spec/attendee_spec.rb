require './lib/attendee'

RSpec.describe Attendee do
    before(:each) do
        @attendee = Attendee.new({name: 'Megan', budget: '$50'})
    end

    it 'exists' do
        expect(@attendee).to be_a(Attendee)
    end

    it 'has attributes' do
        expect(@attendee.name).to eq('Megan')
        expect(@attendee.budget).to eq(50)
    end

    it 'can spend budget' do
        @attendee.spend(22)
        expect(@attendee.budget).to eq(28)
    end
end