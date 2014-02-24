FactoryGirl.define do
  factory :answer_user, class: AnswerUser do
    user
    qa_category
  end
end
