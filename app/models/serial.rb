class Serial < ActiveRecord::Base
  has_attached_file :poster, :styles => { :default => "980x1024"},
  :path => File.join(POSTERS_PATH, ':id', ':basename_:style.:extension').to_s
  
  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :description
  validates_attachment_presence :poster

  def to_param
    self.slug
  end
end
