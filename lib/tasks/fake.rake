require 'lib/repository_container'
require 'lib/repository_factory'
require 'test/factories/repos'

namespace :fake do
  task :load => [:environment, :generate] do
    puts "Indexing..."
    Repository.index!
  end
  
  task :generate => [:environment, :clear] do
    puts "Generating fake repository..."

    fake_path = Rails.root.join('media', 'fake_repo').to_s
    
    FileUtils.cp_r(fake_path, REPOS_PATH)

    Dir[File.join(REPOS_PATH, '*')].each do |serial_repo_path|
      (1..(rand(5)+2)).to_a.each do |season_index|
        season_repo = RepositoryFactory(:season,
                                        :serial_repo_path => serial_repo_path,
                                        :count_episodes => 0,
                                        :index => season_index)

        test_video = Rails.root.join('test', 'factories', 'test').to_s

        (1..(rand(17)+4)).to_a.each do |episode_index|
          episode_file = File.join(season_repo, "episode_#{episode_index}").to_s
          
          ['mp4', 'webm'].each do |format|
            src = test_video + '.' + format
            dst = episode_file + '.' + format
            
            FileUtils.cp(src, dst)
          end
        end
      end
    end
  end

  task :clear => [:environment]do
    [REPOS_PATH, POSTERS_PATH, THUMBNAILS_PATH].each do |dir|
      FileUtils.rm_r(dir) if File.exists?(dir)
    end
  end
end
