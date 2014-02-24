class Group < ActiveRecord::Base
  # Validations
  validates :name, presence: true, length: {maximum: 30}
  validates :description, length: {maximum: 100}

  # Relations
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations
end
