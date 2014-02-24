FactoryGirl.define do
  factory :answer, class: Answer do
    message "Some answer"
    question
    user
  end
end
