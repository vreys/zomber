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

  def first?
    (self.index == 1)
  end

  def last?
    (self.index == self.season.episodes.count)
  end

  def previous
    self.season.episodes.where(:index => (self.index-1)).first unless self.first?
  end

  def next
    self.season.episodes.where(:index => (self.index+1)).first unless self.last?
  end

  def mp4_path
    mp4.gsub(Rails.root.join('media').to_s, '')
  end

  def webm_path
    webm.gsub(Rails.root.join('media').to_s, '')
  end
end
