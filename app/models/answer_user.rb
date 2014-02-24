class AnswerUser < ActiveRecord::Base
  # Validations
  validates :user_id, presence: true
  validates :qa_category_id, presence: true
  validate :duplicate_check

  # Relations
  belongs_to :user
  belongs_to :qa_category

  private
  def duplicate_check
    if AnswerUser.exists?(qa_category_id: qa_category_id, user_id: user_id)
      errors.add(:user_id, "は既に登録されています")
    end
  end
end
