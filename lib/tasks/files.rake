namespace :files do
  desc "Create a location in which to save the file"
  task :create_directory => :environment do
    FileUtils.mkdir_p Rails.root.join("files", "attachments").to_s
  end
end
