class Season < ActiveRecord::Base
  belongs_to :serial
  
  class << self
    def rebuild(container, serial_id)
      Season.create!(:serial_id => serial_id, :index => container.meta.index)
    end
  end

  validates_presence_of :index
  validates_presence_of :serial_id
end
