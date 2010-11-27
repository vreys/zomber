class Serial < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :slug

  def to_param
    self.slug
  end
end
