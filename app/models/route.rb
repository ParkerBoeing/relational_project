class Route < ApplicationRecord
  belongs_to :crag

  def self.bolted_routes
    where(bolted:true)
  end

  def self.alphabetize
    order(:name)
  end
end