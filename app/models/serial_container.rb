class SerialContainer
  include ActiveModel::Validations

  validates_presence_of :meta
  
  def self.build(path)
    return nil unless File.exists?(path)
    meta = SerialMeta.build(path)
    
    self.new(:meta => meta)
  end

  attr_reader :meta

  def initialize(attrs)
    self.meta = attrs[:meta]
  end

  protected

  attr_writer :meta
end
