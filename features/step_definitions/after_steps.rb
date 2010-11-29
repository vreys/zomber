After do
  cleanup_dirs = [REPOS_PATH, POSTERS_PATH, THUMBNAILS_PATH]

  cleanup_dirs.each do |dir_path|
    FileUtils.rm_r(dir_path) if File.exists?(dir_path)
  end
end
