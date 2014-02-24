class CreateFileCategories < ActiveRecord::Migration
  def change
    create_table :file_categories do |t|
      t.string :name, limit: 30, null: false
      t.string :description, limit: 100

      t.timestamps
    end
  end
end
