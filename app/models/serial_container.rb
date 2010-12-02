class SerialContainer < RepositoryContainer::Base
  attributes :title, :alt_title, :slug, :description

  def initialize(path)
    @path = path

    super(attrs_from_meta_file)
  end

  def seasons
    return @seasons if defined?(@seasons)
    
    @seasons = []
    
    read_seasons.each_with_index do |season_path, index|
      @seasons << SeasonContainer.new(:path => season_path, :index => (index+1))
    end

    @seasons
  end

  def poster
    File.new(File.join(@path, 'poster.jpg'))
  end

  def thumbnail
    File.new(File.join(@path, 'thumbnail.jpg'))
  end

  protected

  def read_seasons
    Dir[File.join(@path, '*')].select{|d| File.directory?(d)}.sort
  end

  def attrs_from_meta_file
    meta_file_name = File.basename(@path)
    slug = meta_file_name.gsub('.txt', '')

    f = File.new(File.join(@path, meta_file_name + '.txt'), 'r')
    meta = f.read.split("\n\n").map{|l| l.strip}
    f.close

    title = meta[0]
    alt_title = ''
    
    if title.match(/^(.+) \((.+)\)$/)
      title = $~[1].strip
      alt_title = $~[2].strip
    end
    
    {
      :title => title,
      :alt_title => alt_title,
      :slug => slug,
      :description => meta[1]
    }
  end
end
