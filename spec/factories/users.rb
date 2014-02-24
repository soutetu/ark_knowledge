FactoryGirl.define do
  factory :user, class: User do
    first_name "user_first"
    last_name "user_last"
    first_name_kana "user_first_kana"
    last_name_kana "user_last_kana"
    sequence(:email){|n| "user#{n}@example.com"}
    # Digest::SHA1.hexdigest("salt")
    # salt "b295d117135a9763da282e7dae73a5ca7d3e5b11"
    # Digest::SHA512.hexdigest("salt")
    salt "bd2b1aaf7ef4f09be9f52ce2d8d599674d81aa9d6a4421696dc4d93dd0619d682ce56b4d64a9ef097761ced99e0f67265b5f76085e5b0ee7ca4696b2ad6fe2b2"
    # password is "secret"
    # Digest::SHA1.hexdigest("b295d117135a9763da282e7dae73a5ca7d3e5b11secret")
    # password "25035f9bd4cd06ae49501fee468b7ddb983d04da"
    # Digest::SHA512.hexdigest("bd2b1aaf7ef4f09be9f52ce2d8d599674d81aa9d6a4421696dc4d93dd0619d682ce56b4d64a9ef097761ced99e0f67265b5f76085e5b0ee7ca4696b2ad6fe2b2secret")
    password "84b63eefc9234094a0b76d2c16bda838a1bb936e28eb359c527a03d2094ce5d29c6e1cd5ca407a21e62c07cc79d60513c6ccd94639c58a1ca9689b41adad9577"
    role 0
  end

  factory :super_user, class: User do
    first_name "super_first"
    last_name "super_last"
    first_name_kana "super_first_kana"
    last_name_kana "super_last_kana"
    sequence(:email){|n| "super_user#{n}@example.com"}
    # Digest::SHA1.hexdigest("salt")
    # salt "b295d117135a9763da282e7dae73a5ca7d3e5b11"
    # Digest::SHA512.hexdigest("salt")
    salt "bd2b1aaf7ef4f09be9f52ce2d8d599674d81aa9d6a4421696dc4d93dd0619d682ce56b4d64a9ef097761ced99e0f67265b5f76085e5b0ee7ca4696b2ad6fe2b2"
    # password is "secret"
    # Digest::SHA1.hexdigest("b295d117135a9763da282e7dae73a5ca7d3e5b11secret")
    # password "25035f9bd4cd06ae49501fee468b7ddb983d04da"
    # Digest::SHA512.hexdigest("bd2b1aaf7ef4f09be9f52ce2d8d599674d81aa9d6a4421696dc4d93dd0619d682ce56b4d64a9ef097761ced99e0f67265b5f76085e5b0ee7ca4696b2ad6fe2b2secret")
    password "84b63eefc9234094a0b76d2c16bda838a1bb936e28eb359c527a03d2094ce5d29c6e1cd5ca407a21e62c07cc79d60513c6ccd94639c58a1ca9689b41adad9577"
    role 1
  end
end
