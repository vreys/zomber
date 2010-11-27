class SeasonMeta
  include ActiveModel::Validations
  
  class << self
    def build(season_path, index)
      self.new(season_path, index)
    end
  end

  attr_reader :index

  validates_presence_of :index

  def initialize(season_path, index)
    self.index = index
  end

  protected

  attr_writer :index
end
