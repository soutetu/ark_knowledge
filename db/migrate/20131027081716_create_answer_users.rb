class CreateAnswerUsers < ActiveRecord::Migration
  def change
    create_table :answer_users do |t|
      t.integer :user_id, null: false
      t.integer :qa_category_id, null: false

      t.timestamps
    end
  end
end
