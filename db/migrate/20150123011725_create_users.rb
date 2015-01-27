class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.float :weather_multiplier
      t.float :safety_multiplier
      t.float :distance_multiplier
      t.float :dollars_multiplier

      t.timestamps null: false
    end
  end
end
