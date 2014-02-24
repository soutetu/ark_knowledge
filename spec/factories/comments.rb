FactoryGirl.define do
  factory :comment, class: Comment do
    message "Some comment"
    board
    user
  end
end
