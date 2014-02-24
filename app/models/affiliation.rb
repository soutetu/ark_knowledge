class Affiliation < ActiveRecord::Base
  # Validations
  validates :user_id, presence: true
  validates :group_id, presence: true
  validate :duplicate_check

  # Relations
  belongs_to :user
  belongs_to :group

  private
  def duplicate_check
    if Affiliation.exists?(group_id: group_id, user_id: user_id)
      errors.add(:user_id, "は既に登録されています")
    end
  end
end
