class Serial < ActiveRecord::Base
  has_many :seasons, :dependent => :destroy
  
  has_attached_file :poster, :styles => { :default => "980x1024"},
  :path => File.join(POSTERS_PATH, ':id', ':basename_:style.:extension').to_s,
  :url => File.join(POSTERS_URL_PATH, ':id', ':basename_:style.:extension').to_s

  has_attached_file :thumbnail, :styles => { :default => "120x120" },
  :path => File.join(THUMBNAILS_PATH, ':id', ':basename_:style.:extension').to_s,
  :url => File.join(THUMBNAILS_URL_PATH, ':id', ':basename_:style.:extension').to_s
  
  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :description
  validates_attachment_presence :poster
  validates_attachment_presence :thumbnail

  default_scope order('title ASC')

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
