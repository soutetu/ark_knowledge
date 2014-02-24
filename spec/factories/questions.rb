FactoryGirl.define do
  factory :question, class: Question do
    title "Some title"
    body "Some question"
    status "新規"
    replay_deadline "至急"
    user
    qa_category
  end
end
