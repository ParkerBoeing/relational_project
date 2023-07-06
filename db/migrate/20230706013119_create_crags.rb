class CreateCrags < ActiveRecord::Migration[7.0]
  def change
    create_table :crags do |t|
      t.string :name
      t.integer :elevation
      t.boolean :nearby_camping

      t.timestamps
    end
  end
end
