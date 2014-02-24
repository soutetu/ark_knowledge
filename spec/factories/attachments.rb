FactoryGirl.define do
  factory :attachment, class: Attachment do
    orig_name "file"
    content_type "text/plain"
    file_size 43397
    file_category
    user
  end
end
