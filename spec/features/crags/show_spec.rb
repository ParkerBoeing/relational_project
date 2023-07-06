require 'rails_helper'

RSpec.describe 'crags page' do
  describe 'When I visit /crags' do
    it 'shows the crag name for each crag in the table' do
      crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
      crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
      visit "/crags"
      expect(page).to have_content(crag_1.name)
      expect(page).to have_content(crag_2.name)
    end
  end

  describe 'When I visit crags/:id' do
    it 'shows the crag with the corresponding id and all its attributes' do
      crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
      crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
      visit "/crags/#{crag_1.id}"
      expect(page).to have_content(crag_1.name)
      expect(page).to_not have_content(crag_2.name)
      expect(page).to have_content(crag_1.id)
      expect(page).to_not have_content(crag_2.id)
      expect(page).to have_content(crag_1.elevation)
      expect(page).to have_content(crag_1.nearby_camping)
      expect(page).to_not have_content(crag_2.nearby_camping)
      expect(page).to have_content(crag_1.created_at)
      expect(page).to have_content(crag_1.updated_at)
    end
  end

  describe 'When I visit /routes' do
    xit 'shows each route in the table as well as the routes attributes' do
      crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
      crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
      route_1 = crag_1.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
      route_2 = crag_1.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
      route_3 = crag_2.routes.create!(name: "Extreme Unction", meters_tall: 20, bolted: false)
      route_4 = crag_2.routes.create!(name: "Invocation", meters_tall: 25, bolted: true)

    end
  end
end