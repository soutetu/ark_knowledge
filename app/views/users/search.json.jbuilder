json.array! @users do |user|
  json.name user.fullname
  json.email user.email
end
