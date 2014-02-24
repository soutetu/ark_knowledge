namespace :super_user do
  desc "Create super user"
  task :create => :environment do
    super_user, password = User.new_user(first_name: "user",
      last_name: "super",
      first_name_kana: "user_kana",
      last_name_kana: "super_kana",
      email: "super@example.com",
      role: 1
      )
    super_user.save!
    puts "Super user has been successfully created. Sign-in with 'super@example.com/#{password}'."
  end

  desc "Delete super user"
  task :destroy => :environment do
    super_user = User.find_by(email: "super@example.com")
    if super_user
      super_user.destroy
      puts "Super user has been successfully deleted."
    else
      puts "Super user is not found."
    end
  end
end
