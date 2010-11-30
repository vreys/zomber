RepositoryFactory.define(:serial) do |*args|
  attrs = {
    :title         => Faker::Lorem.words(rand(3)+1).join(' '),
    :slug          => Faker::Lorem.words(rand(3)+2).join('-'),
    :description   => Faker::Lorem.words(rand(6)+5).join(' '),
    :poster        => Rails.root.join('test', 'factories', 'poster.jpg'),
    :thumbnail     => Rails.root.join('test', 'factories', 'thumbnail.jpg'),
    :count_seasons => (rand(6) + 2)
  }

  attrs.merge!(args[0]) if args[0] && args[0].class == Hash

  serial_repo_name = Faker::Lorem.words(rand(5)+1).join('_')

  serial_repo_path = Rails.root.join(REPOS_PATH, serial_repo_name)
  serial_meta_path = serial_repo_path.join("#{serial_repo_name}.txt")

  serial_poster_path = serial_repo_path.join("poster.jpg")
  serial_thumb_path = serial_repo_path.join("thumbnail.jpg")

  FileUtils.makedirs(serial_repo_path)
  
  FileUtils.cp(attrs[:poster], serial_poster_path)
  FileUtils.cp(attrs[:thumbnail], serial_thumb_path)

  meta = File.new(serial_meta_path, 'w')
  meta.puts(attrs[:title], attrs[:slug], attrs[:description])
  meta.close

  attrs[:count_seasons].times.to_a.each do |index|
    RepositoryFactory(:season, :serial_repo_path => serial_repo_path)
  end

  serial_repo_path.to_s
end

RepositoryFactory.define(:season) do |*args|
  attrs = {
    :serial_repo_path => File.join(REPOS_PATH, Faker::Lorem.words(rand(3)+2).join('-')).to_s,
    :index            => (rand(8)+1),
    :count_episodes   => (rand(18)+1)
  }

  attrs.merge!(args[0]) if args[0] && args[0].class == Hash

  season_repo_path = File.join(attrs[:serial_repo_path], "season_#{attrs[:index]}").to_s

  FileUtils.makedirs(season_repo_path)

  attrs[:count_episodes].times.to_a.each do |episode_index|
    RepositoryFactory(:episode, :season_repo_path => season_repo_path, :index => (episode_index+1))
  end

  season_repo_path
end

RepositoryFactory.define(:episode) do |*args|
  attrs = {
    :season_repo_path => File.join(REPOS_PATH, Faker::Lorem.words(rand(3)+2).join('-').to_s,
                                   "season_#{rand(8)+1}").to_s,
    :index => (rand(18)+1)
  }

  attrs.merge!(args[0]) if args[0] && args[0].class == Hash
  
  paths = {}

  FileUtils.makedirs(attrs[:season_repo_path])

  [:mp4, :webm].each do |extension|
    file_path = File.join(attrs[:season_repo_path], "episode_#{attrs[:index]}.#{extension}").to_s

    FileUtils.touch(file_path)

    paths[extension] = file_path
  end

  paths
end
