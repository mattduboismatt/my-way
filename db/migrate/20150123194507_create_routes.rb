class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :travel_mode
      t.integer :distance
      t.integer :duration
      t.integer :dollars
      t.integer :weather
      t.integer :comfort
      t.integer :safety
      t.integer :expected
      t.references :trip

      t.timestamps null: false
    end
  end
end
