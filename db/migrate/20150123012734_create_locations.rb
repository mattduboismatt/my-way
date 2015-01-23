class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :name
      t.float :lat
      t.float :lng
      t.references :user
      t.references :trip

      t.timestamps null: false
    end
  end
end
