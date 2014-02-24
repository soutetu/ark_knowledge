class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, limit: 40, null: false
      t.text :body, null: false
      t.string :status, limit: 20, null: false
      t.string :replay_deadline, limit: 20, null: false
      t.integer :user_id
      t.integer :qa_category_id, null: false

      t.timestamps
    end
  end
end
