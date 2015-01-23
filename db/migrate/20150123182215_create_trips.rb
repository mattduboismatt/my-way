class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user

      t.timestamps null: false
    end
  end
end
