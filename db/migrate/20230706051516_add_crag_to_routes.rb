class AddCragToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_reference :routes, :crag, null: false, foreign_key: true
  end
end
