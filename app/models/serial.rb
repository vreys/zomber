class Serial
  include Mongoid::Document

  # -- Document configuration
  
  identity :type => String
  
  field :title
  field :original_title
  field :description
  field :permalink

  # -- Accociations
  
  embeds_many :seasons

  # -- Callbacsk
  
  before_save :set_id

  # -- Scopes
  
  default_scope ascending(:title)

  public

  # -- Class methods
  
  class << self
    def find_by_permalink(value)
      self.where(:permalink => value).first
    end
  end

  # -- Instance methods
  
  def to_param
    self.permalink
  end
  
  protected

  def set_id
    self.permalink = self.original_title.parameterize
  end
end
