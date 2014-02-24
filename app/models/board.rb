class Board < ActiveRecord::Base
  # Validations
  validates :title, presence: true, length: {maximum: 40}
  validates :body, presence: true
  validates :board_category_id, presence: true

  # Relations
  belongs_to :board_category
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Scopes
  scope :rel_user, lambda {|user| joins("LEFT OUTER JOIN comments ON boards.id = comments.board_id").where("boards.user_id = :i OR comments.user_id = :i", {i: user.id}).uniq}

  class << self
    def new_topic(params, category, user)
      self.new(params).tap do |topic|
        topic.user = user
        topic.board_category = category
      end
    end
  end
end
