class Serial
  include Mongoid::Document

  identity :type => String
  
  field :title
  field :original_title
  field :description

  embeds_many :seasons

  before_save :set_id

  protected

  def set_id
    self._id = self.title.parameterize
  end
end
