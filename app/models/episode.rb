class Episode
  include Mongoid::Document

  field :title
  field :original_title

  # -- Document accocications
  embedded_in :season, :inverse_of => :episodes

  public

  def index
    self._parent.episodes.index(self)+1
  end

  def to_param
    self.index.to_s
  end
end
