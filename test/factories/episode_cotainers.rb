module EpisodeContainerFactory
  def self.create
    EpisodeContainer.build(rand(10)+2)
  end
end
