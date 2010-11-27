module SerialRepoFactory
  def self.create(title = nil, slug = nil)
    title = Faker::Lorem.words(rand(3)+1).join(' ') if title.nil?
    slug = Faker::Lorem.words(rand(3)+2).join('-') if slug.nil?
    
    basename = Faker::Lorem.words(rand(5)+1).join('_')
    
    dir_path = Rails.root.join('tmp', 'serials', basename)
    file_path = File.join(dir_path, basename + '.txt')

    FileUtils.makedirs(dir_path)
    
    f = File.new(file_path, 'w')
    f.puts(title, slug)
    f.close
  end
end
