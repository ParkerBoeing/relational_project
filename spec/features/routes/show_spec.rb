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
    # User Story 14, Child Update 

    # As a visitor
    # When I visit a Child Show page
    # Then I see a link to update that Child "Update Child"
    # When I click the link
    # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
    # When I click the button to submit the form "Update Child"
    # Then a `PATCH` request is sent to '/child_table_name/:id',
    # the child's data is updated,
    # and I am redirected to the Child Show page where I see the Child's updated information
end