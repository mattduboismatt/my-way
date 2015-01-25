class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :travel_mode
      t.integer :distance_exp
      t.integer :duration_exp
      t.integer :dollars_exp
      t.integer :weather_exp
      t.integer :safety_exp
      t.integer :comfort_exp
      t.integer :total_exp

      t.timestamps null: false
    end
  end
end
