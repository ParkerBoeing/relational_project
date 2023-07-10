require 'rails_helper'

RSpec.describe Route do
  it {should belong_to :crag}

  describe 'class methods' do
    before :each do
      @crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
      @crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
      @route_1 = @crag_1.routes.create!(name: "Extreme Unction", meters_tall: 20, bolted: false)
      @route_2 = @crag_1.routes.create!(name: "Invocation", meters_tall: 25, bolted: true)
      @route_3 = @crag_2.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
      @route_4 = @crag_2.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
    end

    describe '#bolted_routes' do
      it 'returns the routes with true boolean values for bolted' do
        bolted_routes = Route.bolted_routes
        expect(bolted_routes).to include(@route_2, @route_3, @route_4)
      end
    end

    describe '#alphabetize' do
      it 'returns the list of routes in alphabetized order' do
        expect(Route.alphabetize).to eq([@route_1, @route_4, @route_2, @route_3])
      end
    end
  end
end