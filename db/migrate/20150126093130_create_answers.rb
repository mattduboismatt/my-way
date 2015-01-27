class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.text :content
      t.float :weather_modifier
      t.float :distance_modifier
      t.float :dollars_modifier
      t.float :safety_modifier

      t.timestamps null: false
    end
  end
end
