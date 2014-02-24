class Attachment < ActiveRecord::Base
  # Validations
  validates :orig_name, presence: true, length: {maximum: 100}
  validates :content_type, presence: true, length: {maximum: 50}
  validates :file_category_id, presence: true

  # Relations
  belongs_to :file_category
  belongs_to :user

  def path
    Rails.root.join("files", "attachments", self.id.to_s).to_s
  end

  class << self
    def new_file(file, category, user)
      self.new(
        orig_name: file.original_filename,
        content_type: file.content_type,
        file_size: file.size
        ).tap do |file|
        file.file_category = category
        file.user = user
      end
    end
  end
end
