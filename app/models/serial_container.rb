class SerialContainer
  include ActiveModel::Validations

  validates_presence_of :meta
  
  def self.build(path)
    return nil unless File.exists?(path)
    meta = SerialMeta.build(path)
    seasons = []
    
    Dir[File.join(path, '*')].select{|d| File.directory?(d)}.sort.each_with_index do |season_path, index|
      seasons << SeasonContainer.build(season_path, (index+1))
    end
    
    self.new(:meta => meta, :seasons => seasons)
  end

  attr_reader :meta, :seasons

  def initialize(attrs)
    self.meta = attrs[:meta]
    self.seasons = attrs[:seasons] || []
  end

  protected

  attr_writer :meta, :seasons
end
