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
      expect(@crag_2.name).to appear_before(@crag_1.name)
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

    it 'next to each crag there is a link to update that crag' do
      visit "/crags"
      click_on "Watchtower Update"
      expect(current_path).to eq("/crags/#{@crag_1.id}/edit")
      visit "/crags"
      click_on "Diablo Update"
      expect(current_path).to eq("/crags/#{@crag_2.id}/edit")
    end

    it 'has a button to delete the crag' do
      visit "/crags"
      expect(page).to have_content("Diablo")
      expect(page).to have_content("Watchtower")

      click_on "Watchtower Delete"
      expect(current_path).to eq("/crags")

      expect(page).to have_content("Diablo")
      expect(page).to_not have_content("Watchtower")
    end
  end

  describe 'When I visit /crags/new' do
    it 'has fields to create new crag' do
      visit "/crags/new"
      fill_in('crag[name]', with: 'Hell')
      fill_in('crag[elevation]', with: 9500)
      fill_in('crag[nearby_camping]', with: true)
      click_button('submit')
      new_crag_name = Crag.last.name
      expect(current_path).to eq("/crags")
      expect(page).to have_content(new_crag_name)
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
      expect(page).to have_content("Number of routes: 2")
    end

    it 'has a button to enable updates' do
      visit "/crags/#{@crag_1.id}"
      click_on "Update Crag"
      expect(current_path).to eq("/crags/#{@crag_1.id}/edit")

      fill_in('crag[name]', with: 'Hell')
      fill_in('crag[elevation]', with: 9500)
      fill_in('crag[nearby_camping]', with: true)
      click_button('submit')
      expect(current_path).to eq("/crags/#{@crag_1.id}")

      expect(page).to have_content("Hell")
      expect(page).to_not have_content("Watchtower")
      expect(page).to have_content(9500)
      expect(page).to_not have_content(4500)
      expect(page).to have_content(true)
      expect(page).to_not have_content(false)
    end

    it 'has a button to delete the crag' do
      visit "/crags"
      expect(page).to have_content("Diablo")
      expect(page).to have_content("Watchtower")

      visit "/crags/#{@crag_1.id}"

      click_on "Delete"
      expect(current_path).to eq("/crags")

      expect(page).to have_content("Diablo")
      expect(page).to_not have_content("Watchtower")
    end
  end

  describe 'When I visit /crags/:crag_id/routes' do
    it 'shows each route associated with the crag as well as the routes attributes' do
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

    it 'has a link to create child automatically associated with given crag ID' do
      visit "/crags/#{@crag_1.id}/routes"
      click_on "Create Route"
      expect(current_path).to eq("/crags/#{@crag_1.id}/routes/new")
    end

    it 'can create a child automatically associated with given crag ID' do
      visit "/crags/#{@crag_1.id}/routes/new"
      fill_in('route[name]', with: 'Escapades')
      fill_in('route[meters_tall]', with: 30)
      fill_in('route[bolted]', with: true)
  
      click_button('submit')
      expect(current_path).to eq("/crags/#{@crag_1.id}/routes")

      expect(page).to have_content("Escapades")
      expect(page).to have_content(30)
      expect(page).to have_content(true)
    end

    it 'has a link to alphabetize the order of routes' do
      @route_5 = @crag_2.routes.create!(name: "Astroman", meters_tall: 40, bolted: true)
      visit "/crags/#{@crag_2.id}/routes"
      expect(@route_3.name).to appear_before(@route_4.name)
      expect(@route_4.name).to appear_before(@route_5.name)

      click_on "Alphabetize"

      expect(@route_5.name).to appear_before(@route_4.name)
      expect(@route_4.name).to appear_before(@route_3.name)
    end

    it 'next to each route there is a link to update that route' do
      visit "/crags/#{@crag_1.id}/routes"
      click_on "Extreme Unction Update"
      expect(current_path).to eq("/routes/#{@route_1.id}/edit")
      visit "/crags/#{@crag_1.id}/routes"
      click_on "Invocation Update"
      expect(current_path).to eq("/routes/#{@route_2.id}/edit")
    end
  end
end