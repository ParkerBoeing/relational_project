class Crag < ApplicationRecord
  has_many :routes

  def routes_count
    self.routes.count
  end
end