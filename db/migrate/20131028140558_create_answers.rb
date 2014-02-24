class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :message, null: false
      t.integer :question_id, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
