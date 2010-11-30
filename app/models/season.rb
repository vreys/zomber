class Season < ActiveRecord::Base
  belongs_to :serial
  has_many :episodes, :dependent => :destroy
  
  class << self
    def import!(container)
      season = create!(container.attributes)

      container.episodes.each do |episode_container|
        season.episodes.import!(episode_container)
      end
    end
  end

  validates_presence_of :index
  validates_presence_of :serial_id
end
