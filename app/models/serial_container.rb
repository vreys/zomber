class SerialContainer < RepositoryContainer::Base
  attributes :title, :slug, :description

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

    f = File.new(File.join(@path, meta_file_name + '.txt'), 'r')
    lines = f.readlines.map{|l| l.strip}
    f.close

    {
      :title => lines[0],
      :slug => lines[1],
      :description => lines[2]
    }
  end
end
