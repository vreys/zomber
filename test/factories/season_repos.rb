module SeasonRepoFactory
  def self.create(serial_path = nil, index = 1, count_episodes = nil)
    serial_path = File.join(REPOS_PATH, Faker::Lorem.words(rand(3)+2).join('-')).to_s if serial_path.nil?
    path = File.join(serial_path, "season #{index}").to_s

    FileUtils.makedirs(path)

    count_episodes = rand(16) + 2 if count_episodes.nil?
    
    (1..count_episodes.to_i).to_a.each do |episode_index|
      FileUtils.touch(File.join(path, "episode #{episode_index}.mp4").to_s)
    end
    
    path
  end
end
