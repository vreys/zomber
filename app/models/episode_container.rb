class EpisodeContainer
  include ActiveModel::Validations
  
  class << self
    def build(index)
      meta = EpisodeMeta.new(index)

      new(:meta => meta)
    end
  end

  attr_reader :meta

  validates_presence_of :meta

  def initialize(options)
    self.meta = options[:meta]
  end

  protected

  attr_writer :meta
end
