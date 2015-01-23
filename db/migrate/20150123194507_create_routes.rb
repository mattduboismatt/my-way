class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :travel_mode
      t.integer :distance
      t.integer :duration
      t.integer :dollars
      t.integer :score
      t.references :trip

      t.timestamps null: false
    end
  end
end
