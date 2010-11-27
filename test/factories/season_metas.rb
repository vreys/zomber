module SeasonMetaFactory
  def self.create(season_path = nil, index = nil)
    index = (rand(10) + 1)
    season_path = File.join(REPOS_PATH, Faker::Lorem.words(rand(2)+2).join('-'), "season #{index}").to_s

    FileUtils.makedirs(season_path)

    SeasonMeta.build(season_path, index)
  end
end
