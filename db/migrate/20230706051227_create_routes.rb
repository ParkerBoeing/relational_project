class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :meters_tall
      t.boolean :bolted

      t.timestamps
    end
  end
end
