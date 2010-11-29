class EpisodeMeta

  attr_reader :index
  
  def initialize(index)
    self.index = index
  end

  protected

  attr_writer :index
end
