FactoryGirl.define do
  factory :board, class: Board do
    title "Some title"
    body "Some knowledge"
    user
    board_category
  end
end
