class Question < ActiveRecord::Base
  # Validations
  validates :title, presence: true, length: {maximum: 40}
  validates :body, presence: true
  validates :status, presence: true, inclusion: {in: ["新規", "調査中", "保留", "回答済", "解決済み", "未解決"]}
  validates :replay_deadline, presence: true, inclusion: {in: ["至急", "1週間以内", "手が空いたら"]}
  validates :qa_category_id, presence: true

  # Relations
  belongs_to :user
  belongs_to :qa_category
  has_many :answers, dependent: :destroy

  # Scopes
  scope :rel_user, lambda {|user| joins(:qa_category).joins("LEFT OUTER JOIN answers ON questions.id = answers.question_id").where("qa_categories.id IN (:m) OR questions.user_id = :i OR answers.user_id = :i", {m: user.qa_categories.pluck(:id), i: user.id}).uniq.order("questions.updated_at DESC")}

  class << self
    def new_question(params, category, user)
      self.new(params).tap do |question|
        question.user = user
        question.qa_category = category
      end
    end
  end
end
