class SerialMeta
  include ActiveModel::Validations

  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :description
  validates_presence_of :poster
  
  class << self
    def build(path)
      data = read(path)

      new(data)
    end

    def read(path)
      basename = File.basename(path)

      f = File.new(File.join(path, basename + '.txt'), 'r')
      lines = f.readlines.map{|l| l.strip}
      f.close

      {
        :title => lines[0],
        :slug => lines[1],
        :description => lines[2],
        :poster => File.join(path, 'poster.jpg')
      }
    end
  end

  attr_reader :title, :slug, :description, :poster

  def initialize(data)
    self.poster = File.new(data.delete(:poster))

    data.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def attributes
    attrs = {}
    
    [:title, :slug, :description, :poster].each do |attr|
      attrs[attr] = self.send(attr)
    end

    attrs
  end

  protected

  attr_writer :title, :slug, :description, :poster
end
