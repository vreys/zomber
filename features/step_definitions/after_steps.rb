After do
  cleanup_dirs = [REPOS_PATH, POSTERS_PATH, THUMBNAILS_PATH]

  cleanup_dirs.each do |dir_path|
    FileUtils.rm_r(dir_path) if File.exists?(dir_path)
  end
end

After do
  @my_email = ''
  @my_name = ''
end

After do
  mails_dir = ActionMailer::Base.file_settings[:location]
  
  FileUtils.rm_r(mails_dir) if File.exists?(mails_dir)
end

