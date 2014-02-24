class Comment < ActiveRecord::Base
  # Validations
  validates :message, presence: true
  validates :board_id, presence: true

  # Relations
  belongs_to :board
  belongs_to :user
end
