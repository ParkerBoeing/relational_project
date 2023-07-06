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
      visit "/crags/#{@crag.id}"
      expect(page).to have_content(crag_1.name)
      expect(page).to have_content(crag_2.name)
      expect(page).to have_content(crag_1.id)
      expect(page).to have_content(crag_2.id)
      expect(page).to have_content(crag_1.elevation)
      expect(page).to have_content(crag_2.elevation)
      expect(page).to have_content(crag_1.nearby_camping)
      expect(page).to have_content(crag_2.nearby_camping)
      expect(page).to have_content(crag_1.created_at)
      expect(page).to have_content(crag_2.created_at)
      expect(page).to have_content(crag_1.updated_at)
      expect(page).to have_content(crag_2.updated_at)
    end
  end
end