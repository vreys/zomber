module SerialRepoFactory
  def self.create(attrs = {})
    attrs = { :title => Faker::Lorem.words(rand(3)+1).join(' '),
      :slug => Faker::Lorem.words(rand(3)+2).join('-'),
      :description => Faker::Lorem.words(rand(6)+5).join(' '),
      :poster => Rails.root.join('test', 'factories', 'poster.jpg'),
      :count_seasons => (rand(6) + 2)}.merge(attrs)
    
    basename = Faker::Lorem.words(rand(5)+1).join('_')
    
    dir_path = Rails.root.join(REPOS_PATH, basename)
    file_path = File.join(dir_path, basename + '.txt')
    poster_path = File.join(dir_path, 'poster.jpg')

    FileUtils.makedirs(dir_path)
    FileUtils.cp(attrs[:poster], poster_path)

    f = File.new(file_path, 'w')
    f.puts(attrs[:title], attrs[:slug], attrs[:description])
    f.close

    if attrs[:count_seasons].to_i > 0
      (1..attrs[:count_seasons].to_i).to_a.each do |index|
        SeasonRepoFactory.create(dir_path, index)
      end
    end

    dir_path.to_s
  end
end
