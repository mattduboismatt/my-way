class CreateDivvies < ActiveRecord::Migration
  def change
    create_table :divvies do |t|
      t.integer :station_id
      t.string :station_name
      t.integer :available_docks
      t.integer :total_docks
      t.float :lat
      t.float :lng
      t.string :status_value
      t.integer :available_bikes
      t.string :address

      t.timestamps null: false
    end
  end
  # add_index :divvies, :station_id
  # add_index :divvies, :lng
  # add_index :divvies, :lat
end
