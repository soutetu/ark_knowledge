class Answer < ActiveRecord::Base
  # Validations
  validates :message, presence: true
  validates :question_id, presence: true

  # Relations
  belongs_to :question
  belongs_to :user
end
