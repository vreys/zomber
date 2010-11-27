class SeasonContainer
  include ActiveModel::Validations

  validates_presence_of :meta

  class << self
    def build(season_path, index)
      meta = SeasonMeta.build(season_path, index)

      self.new(:meta => meta)
    end
  end

  attr_reader :meta
  
  def initialize(attrs)
    self.meta = attrs[:meta]
  end

  protected

  attr_writer :meta
end
