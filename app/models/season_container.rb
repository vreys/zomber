class SeasonContainer < RepositoryContainer::Base
  attributes :index

  def initialize(attrs)
    @path = attrs.delete(:path)

    super(attrs)
  end

  def episodes
    return @episodes if defined?(@episodes)

    @episodes = []
    
    mp4s_episodes = read_episodes('mp4')
    webm_episodes = read_episodes('webm')

    mp4s_episodes.each_with_index do |mp4, index|
      attrs = {
        :mp4 => mp4,
        :webm => webm_episodes[index],
        :index => (index+1)
      }

      @episodes << EpisodeContainer.new(attrs)
    end

    @episodes
  end

  protected

  def read_episodes(ext)
    Dir[File.join(@path, "*.#{ext}")].sort
  end
end
