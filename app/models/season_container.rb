class SeasonContainer
  include ActiveModel::Validations

  validates_presence_of :meta

  class << self
    def build(season_path, index)
      meta = SeasonMeta.build(season_path, index)
      episodes = []

      Dir[File.join(season_path, '*')].sort.each_with_index do |f, episode_index|
        episodes << EpisodeContainer.build((episode_index+1))
      end

      self.new(:meta => meta, :episodes => episodes)
    end
  end

  attr_reader :meta, :episodes
  
  def initialize(attrs)
    self.meta = attrs[:meta]
    self.episodes = attrs[:episodes] || []
  end

  protected

  attr_writer :meta, :episodes
end
