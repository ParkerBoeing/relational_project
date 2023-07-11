require 'rails_helper'

RSpec.describe Crag do
  it {should have_many(:routes).dependent(:destroy)}

  describe 'instance methods' do
    before :each do
      @crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
      @crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
      @route_1 = @crag_1.routes.create!(name: "Extreme Unction", meters_tall: 20, bolted: false)
      @route_2 = @crag_1.routes.create!(name: "Invocation", meters_tall: 25, bolted: true)
      @route_3 = @crag_2.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
      @route_4 = @crag_2.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
    end

    describe '#routes_count' do
      it 'returns the number of routes associated with the crag' do
        expect(@crag_1.routes_count).to eq(2)
      end
    end
  end
end