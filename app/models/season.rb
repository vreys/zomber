class Season
  include Mongoid::Document

  # -- Document accocications
  
  embedded_in :serial, :inverse_of => :seasons
  embeds_many :episodes, :type => Integer

  # -- Document fields

  field :index_number, :type => Integer

  # -- Validations

  validates_uniqueness_of :index_number

  # -- Callbacks

  before_create :set_index_number
  after_destroy :update_others_index_numbers

  # -- Scopes

  # NOT WORKING FOR EMBED DOCUMENTS
  # default_scope criteria.ascending("index_number")

  public

  # -- Instance mehods
  
  def to_param
    self.index_number.to_s
  end

  def decrease_index_number!
    return if self.first?
    
    prev = self.previous
    
    self.safely.inc(:index_number, -1)
    prev.safely.inc(:index_number, 1)

    self.save and prev.save
  end

  def previous
    self.serial.seasons.find_by_index_number(self.index_number - 1) unless first?
  end

  def first?
    return true if self.index_number == 1

    false
  end

  def next
    self.serial.seasons.find_by_index_number(self.index_number + 1) unless last?
  end

  def last?
    return true if self.index_number == self.serial.seasons.count

    false
  end
  
  protected

  def set_index_number
    self.index_number = self.serial.seasons.count+1
  end

  def update_others_index_numbers
    self.serial.seasons.each_with_index do |s, i| 
      s.update_attributes(:index_number => (i + 1))
    end
  end
end
