require 'rails_helper'

RSpec.describe 'routes page' do
  before :each do
    @crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false)
    @crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
    @route_1 = @crag_1.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
    @route_2 = @crag_1.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
  end
  describe 'When I visit /routes' do
    it 'shows each route in the table as well as the routes attributes' do
      visit "/routes"
      expect(page).to have_content(@route_1.name)
      expect(page).to have_content(@route_1.id)
      expect(page).to have_content(@route_1.meters_tall)
      expect(page).to have_content(@route_1.bolted)
      expect(page).to have_content(@route_1.created_at)
      expect(page).to have_content(@route_1.updated_at)
      expect(page).to have_content(@route_1.crag_id)
      expect(page).to have_content(@route_2.name)
      expect(page).to have_content(@route_2.id)
      expect(page).to have_content(@route_2.meters_tall)
      expect(page).to have_content(@route_2.bolted)
      expect(page).to have_content(@route_2.created_at)
      expect(page).to have_content(@route_2.updated_at)
      expect(page).to have_content(@route_2.crag_id)
    end

    it 'has a link back to the crags index page' do
      visit "/routes"
      click_on "Crags Index"
      expect(current_path).to eq("/crags")
    end
  end

  describe 'When I visit routes/:id' do
    it 'shows the route with the corresponding id and all its attributes' do
      visit "/routes/#{@route_1.id}"
      expect(page).to have_content(@route_1.name)
      expect(page).to_not have_content(@route_2.name)
      expect(page).to have_content(@route_1.id)
      expect(page).to have_content(@route_1.meters_tall)
      expect(page).to have_content(@route_1.bolted)
      expect(page).to have_content(@route_1.created_at)
      expect(page).to have_content(@route_1.updated_at)
      expect(page).to have_content(@route_1.crag_id)
    end

    it 'has a link back to the crags index page' do
      visit "/routes/#{@route_1.id}"
      click_on "Crags Index"
      expect(current_path).to eq("/crags")
    end

    it 'has a link back to the routes index page' do
      visit "/routes/#{@route_1.id}"
      click_on "Routes Index"
      expect(current_path).to eq("/routes")
    end
  end
end