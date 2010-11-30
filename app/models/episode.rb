class Episode < ActiveRecord::Base
  belongs_to :season

  validates_presence_of :index
  validates_presence_of :season_id
  validates_presence_of :mp4
  validates_presence_of :webm
  
  class << self
    def import!(container)
      create!(container.attributes)
    end
  end
end
