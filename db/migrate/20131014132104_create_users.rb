class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 20, null: false
      t.string :last_name, limit: 20, null: false
      t.string :first_name_kana, limit: 40, null: false
      t.string :last_name_kana, limit: 40, null: false
      t.string :email, limit: 100, null: false
      t.string :salt, null: false
      t.string :password, null: false
      t.integer :role, default: 0, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
