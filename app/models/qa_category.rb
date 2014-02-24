class QaCategory < ActiveRecord::Base
  # Validations
  validates :name, presence: true, length: {maximum: 30}
  validates :description, length: {maximum: 100}

  # Relations
  has_many :answer_users, dependent: :destroy
  has_many :users, through: :answer_users
  has_many :questions, dependent: :destroy

  def category_manager?(user)
    AnswerUser.exists?(qa_category_id: self.id, user_id: user.id)
  end
end
