class Serial
  include Mongoid::Document

  # -- Document configuration
  
  identity :type => String
  
  field :title
  field :original_title
  field :description
  field :permalink

  index :permalink, :unique => true

  # -- Accociations
  
  embeds_many :seasons do
    def find_by_index_number(value)
      @target.select{ |season| season.index_number == value.to_i }.first
    end
  end

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
