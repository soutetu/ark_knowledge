class FileCategory < ActiveRecord::Base
  # Validations
  validates :name, presence: true, length: {maximum: 30}
  validates :description, length: {maximum: 100}

  # Relations
  has_many :attachments, dependent: :destroy
end
