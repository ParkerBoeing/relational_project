require 'rails_helper'

RSpec.describe 'crags page' do
  before :each do
    @crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false, created_at: 1.day.ago)
    @crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
    @route_1 = @crag_1.routes.create!(name: "Extreme Unction", meters_tall: 20, bolted: false)
    @route_2 = @crag_1.routes.create!(name: "Invocation", meters_tall: 25, bolted: true)
    @route_3 = @crag_2.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
    @route_4 = @crag_2.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
  end

  describe 'When I visit /crags' do
    it 'shows the crag name for each crag in the table' do
      visit "/crags"
      expect(page).to have_content(@crag_1.name)
      expect(page).to have_content(@crag_2.name)
    end

    it 'has a link back to the routes index page' do
      visit "/crags"
      click_on "Routes Index"
      expect(current_path).to eq("/routes")
    end

    it 'displays crags sorted by most recently created' do
      visit "/crags"
      crags = page.all('.h3').map
    end

    it 'displays when the crag was created' do
      visit "/crags"
      expect(page).to have_content(@crag_1.created_at)
      expect(page).to have_content(@crag_2.created_at)
    end

    it 'has a link back to create a new crag' do
      visit "/crags"
      click_on "New Crag"
      expect(current_path).to eq("/crags/new")
    end
  end

  describe 'When I visit /crags/new' do
    it 'has fields to create new crag' do
      visit "/crags/new"
      save_and_open_page
      expect(page).to have_content(@crag_1.created_at)
    end
  end

  describe 'When I visit crags/:id' do
    it 'shows the crag with the corresponding id and all its attributes' do
      visit "/crags/#{@crag_1.id}"
      expect(page).to have_content(@crag_1.name)
      expect(page).to_not have_content(@crag_2.name)
      expect(page).to have_content(@crag_1.id)
      expect(page).to_not have_content(@crag_2.id)
      expect(page).to have_content(@crag_1.elevation)
      expect(page).to have_content(@crag_1.nearby_camping)
      expect(page).to_not have_content(@crag_2.nearby_camping)
      expect(page).to have_content(@crag_1.created_at)
      expect(page).to have_content(@crag_1.updated_at)
    end


    it 'has a link back to the crag index page' do
      visit "/crags/#{@crag_1.id}"
      click_on "Crags Index"
      expect(current_path).to eq("/crags")
    end

    it 'has a link back to the routes index page' do
      visit "/crags/#{@crag_1.id}"
      click_on "Routes Index"
      expect(current_path).to eq("/routes")
    end

    it 'has a link to an index page with all the routes associated with the crag' do
      visit "/crags/#{@crag_1.id}"
      click_on "Routes"
      expect(current_path).to eq("/crags/#{@crag_1.id}/routes")
    end

    it 'shows the number of routes associated' do
      visit "/crags/#{@crag_1.id}"
      # save_and_open_page
      expect(page).to have_content("Number of routes: 2")
    end
  end

  describe 'When I visit /crags/:crag_id/routes' do
    it 'shows each route in the table as well as the routes attributes' do
      visit "/crags/#{@crag_1.id}/routes"
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
      expect(page).to_not have_content(@route_3.name)
      expect(page).to_not have_content(@route_4.name)
    end

    it 'has a link back to the crag index page' do
      visit "/crags/#{@crag_1.id}/routes"
      click_on "Crags Index"
      expect(current_path).to eq("/crags")
    end

    it 'has a link back to the routes index page' do
      visit "/crags/#{@crag_1.id}/routes"
      click_on "Routes Index"
      expect(current_path).to eq("/routes")
    end
  end
end