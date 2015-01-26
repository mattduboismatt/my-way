class CreateUsersAnswers < ActiveRecord::Migration
  def change
    create_table :users_answers do |t|
      t.references :user
      t.references :answer

      t.timestamps null: false
    end
  end
end
