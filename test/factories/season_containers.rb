module SeasonContainerFactory
  def self.create(season_path = nil, index = nil)
    index = (rand(10)+1) if index.nil?
    season_path = SeasonRepoFactory.create(season_path, index)
    meta = SeasonMeta.new(season_path, index)
    
    SeasonContainer.new(:meta => meta)
  end
end
