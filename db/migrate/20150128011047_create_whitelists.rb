class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.references :user
      t.integer :walking
      t.integer :bicycling
      t.integer :divvy
      t.integer :bus
      t.integer :subway
      t.integer :uber
      t.integer :cab
      t.integer :driving

      t.timestamps null: false
    end
  end
end
