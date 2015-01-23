class CreateCtaTrainStops < ActiveRecord::Migration
  def change
    create_table :cta_train_stops do |t|
      t.integer :stop_id
      t.string :direction_id
      t.string :stop_name
      t.float :lng
      t.float :lat
      t.string :station_name
      t.string :station_descriptive_name
      t.string :parent_stop_id
      t.boolean :ada
      t.boolean :red
      t.boolean :brn
      t.boolean :g
      t.boolean :p
      t.boolean :pexp
      t.boolean :pink
      t.boolean :org
      t.boolean :blue
      t.boolean :y

      t.timestamps null: false
    end

  end
end
