class Season
  include Mongoid::Document

  # -- Document accocications
  
  embedded_in :serial, :inverse_of => :seasons

  embeds_many :episodes

  public

  # -- Class methods
  
  class << self
    def find_by_index(value)
      self.criteria.at(value.to_i-1)
    end
  end

  # -- Instance mehods
  
  def to_param
    self.index.to_s
  end
  
  def index
    self.serial.seasons.index(self)+1
  end
end
