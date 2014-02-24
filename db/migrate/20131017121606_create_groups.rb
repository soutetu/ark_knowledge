class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, limit: 30, null: false
      t.string :description, limit: 100

      t.timestamps
    end
  end
end
