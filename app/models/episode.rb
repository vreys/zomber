class Episode < ActiveRecord::Base
  belongs_to :season

  validates_presence_of :index
  validates_presence_of :season_id
  
  class << self
    def rebuild(container, season_id)
      Episode.create!(:season_id => season_id, :index => container.meta.index)
    end
  end
end
