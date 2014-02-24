class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message, null: false
      t.integer :board_id, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
