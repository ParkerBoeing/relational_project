class Crag < ApplicationRecord
  has_many :routes, dependent: :destroy

  def routes_count
    self.routes.count
  end
end