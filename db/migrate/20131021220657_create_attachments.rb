class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :orig_name, limit: 100, null: false
      t.string :content_type, limit: 50, null: false
      t.integer :file_size
      t.integer :file_category_id, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
