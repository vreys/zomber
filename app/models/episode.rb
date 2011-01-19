class Episode
  include Mongoid::Document

  field :title
  field :original_title

  # -- Document accocications
  
  embedded_in :season, :inverse_of => :episodes

  public

  # -- Class Methods
  
  class << self
    def find_by_index(value)
      self.criteria.at(value.to_i-1)
    end
  end

  # -- Instance Methods
  
  def index
    self._parent.episodes.index(self)+1
  end

  def to_param
    self.index.to_s
  end
end
