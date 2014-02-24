class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
