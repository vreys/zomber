module SeasonContainerFactory
  def self.create(season_path = nil, index = nil, count_episodes = nil)
    index = (rand(10)+1) if index.nil?
    season_path = SeasonRepoFactory.create(season_path, index)
    meta = SeasonMeta.new(season_path, index)
    episodes = []

    count_episodes = (rand(8) + 2) if count_episodes.nil?

    (1..count_episodes).to_a.each do |episode_index|
      episodes << EpisodeContainer.build(episode_index)
    end
    
    SeasonContainer.new(:meta => meta, :episodes => episodes)
  end
end
