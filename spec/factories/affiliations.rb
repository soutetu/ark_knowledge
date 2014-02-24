FactoryGirl.define do
  factory :affiliation, class: Affiliation do
    user
    group
  end
end
