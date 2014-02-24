class User < ActiveRecord::Base
  include Passwd::ActiveRecord
  define_column id: :email, salt: :salt, password: :password

  # Validations
  validates :first_name, presence: true, length: {maximum: 20}
  validates :last_name, presence: true, length: {maximum: 20}
  validates :first_name_kana, presence: true, length: {maximum: 40}
  validates :last_name_kana, presence: true, length: {maximum: 40}
  validates :email, presence: true, length: {maximum: 100}, uniqueness: true
  validates :role, inclusion: {in: 0..1}

  # Relations
  has_many :affiliations, dependent: :destroy
  has_many :groups, through: :affiliations
  has_many :attachments, dependent: :nullify
  has_many :boards, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :answer_users, dependent: :destroy
  has_many :qa_categories, through: :answer_users
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  # Scopes
  scope :search, lambda {|key| where("first_name LIKE :key OR first_name_kana LIKE :key OR last_name LIKE :key OR last_name_kana LIKE :key OR email LIKE :key", {key: "%#{key}%"})}

  def super_user?
    role == 1
  end

  def fullname
    "#{last_name} #{first_name}"
  end

  def fullname_kana
    "#{last_name_kana} #{first_name_kana}"
  end

  class << self
    def new_user(params)
      user = self.new(params)
      password = user.set_password
      [user, password]
    end
  end
end
