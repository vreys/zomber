class Season < ActiveRecord::Base
  belongs_to :serial
  has_many :episodes
  
  class << self
    def rebuild(container, serial_id)
      season = Season.create!(:serial_id => serial_id, :index => container.meta.index)

      container.episodes.each do |episode|
        Episode.rebuild(episode, season.id)
      end
      
      season
    end
  end

  validates_presence_of :index
  validates_presence_of :serial_id
end
