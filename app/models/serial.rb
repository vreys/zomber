class Serial < ActiveRecord::Base
  has_many :seasons
  
  has_attached_file :poster, :styles => { :default => "980x1024"},
  :path => File.join(POSTERS_PATH, ':id', ':basename_:style.:extension').to_s,
  :url => File.join(POSTERS_URL_PATH, ':id', ':basename_:style.:extension').to_s
  
  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :description
  validates_attachment_presence :poster

  class << self
    def rebuild(container)
      serial = Serial.create!(container.meta.attributes)

      container.seasons.each do |season_container|
        Season.rebuild(season_container, serial.id)
      end

      serial
    end
  end

  def to_param
    self.slug
  end
end
