require 'rails_helper'

RSpec.describe 'routes page' do
  before :each do
    @crag_1 = Crag.create!(name: "Watchtower", elevation: 4500, nearby_camping: false, created_at: 1.day.ago)
    @crag_2 = Crag.create!(name: "Diablo", elevation: 9000, nearby_camping: true)
    @route_1 = @crag_1.routes.create!(name: "Extreme Unction", meters_tall: 20, bolted: false)
    @route_2 = @crag_1.routes.create!(name: "Invocation", meters_tall: 25, bolted: true)
    @route_3 = @crag_2.routes.create!(name: "Malvado", meters_tall: 15, bolted: true)
    @route_4 = @crag_2.routes.create!(name: "Inferno", meters_tall: 10, bolted: true)
  end
  describe 'When I visit /routes' do
    it 'shows each route in the table as well as the routes attributes, as long as bolted is assigned as true' do
      visit "/routes"
      expect(page).to_not have_content(@route_1.name)
      expect(page).to_not have_content(@route_1.bolted)


      expect(page).to have_content(@route_2.name)
      expect(page).to have_content(@route_2.id)
      expect(page).to have_content(@route_2.meters_tall)
      expect(page).to have_content(@route_2.bolted)
      expect(page).to have_content(@route_2.created_at)
      expect(page).to have_content(@route_2.updated_at)
      expect(page).to have_content(@route_2.crag_id)

      expect(page).to have_content(@route_3.name)
      expect(page).to have_content(@route_3.id)
      expect(page).to have_content(@route_3.meters_tall)
      expect(page).to have_content(@route_3.bolted)
      expect(page).to have_content(@route_3.created_at)
      expect(page).to have_content(@route_3.updated_at)
      expect(page).to have_content(@route_3.crag_id)

      expect(page).to have_content(@route_4.name)
      expect(page).to have_content(@route_4.id)
      expect(page).to have_content(@route_4.meters_tall)
      expect(page).to have_content(@route_4.bolted)
      expect(page).to have_content(@route_4.created_at)
      expect(page).to have_content(@route_4.updated_at)
      expect(page).to have_content(@route_4.crag_id)
    end

    it 'has a link back to the crags index page' do
      visit "/routes"
      click_on "Crags Index"
      expect(current_path).to eq("/crags")
    end

    it 'next to each route there is a link to update that route' do
      visit "/routes"
      click_on "Extreme Unction Update"
      expect(current_path).to eq("/crags/#{@route_1.id}/edit")
      
      visit "/routes"
      click_on "Invocation Update"
      expect(current_path).to eq("/crags/#{@route_2.id}/edit")

      visit "/routes"
      click_on "Malvado Update"
      expect(current_path).to eq("/crags/#{@route_3.id}/edit")

      visit "/routes"
      click_on "Inferno Update"
      expect(current_path).to eq("/crags/#{@route_2.id}/edit")
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

  describe 'route update' do
    it 'has a link to update the information of the route' do
      visit "/routes/#{@route_1.id}"
      click_on "Update Route"
      expect(current_path).to eq("/routes/#{@route_1.id}/edit")

      fill_in('route[name]', with: 'Cosmic Journey')
      fill_in('route[meters_tall]', with: 30)
      fill_in('route[bolted]', with: false)
      click_button('submit')
      expect(current_path).to eq("/routes/#{@route_1.id}")

      expect(page).to have_content("Cosmic Journey")
      expect(page).to_not have_content("Malvado")
      expect(page).to have_content(30)
      expect(page).to_not have_content(15)
      expect(page).to have_content(false)
      expect(page).to_not have_content(true)
    end
  end
end