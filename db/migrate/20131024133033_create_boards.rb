class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title, limit: 40, null: false
      t.text :body, null: false
      t.integer :user_id
      t.integer :board_category_id, null: false

      t.timestamps
    end
  end
end
