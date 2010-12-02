namespace :images do
  task :clear => [:environment] do
    [POSTERS_PATH, THUMBNAILS_PATH].each do |dir|
      FileUtils.rm_r(dir) if File.exists?(dir)
    end
  end
end
