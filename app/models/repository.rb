class Repository
  class << self
    def index!
      Dir[Rails.root.join(REPOS_PATH, '**')].each do |dir|
        basename = File.basename(dir)

        meta = File.new(File.join(dir, basename + '.txt'), 'r')
        poster = File.join(dir, 'poster.jpg').to_s
        attrs = meta.readlines
        meta.close

        Serial.create!(:title => attrs[0].strip,
                       :slug => attrs[1].strip,
                       :description => attrs[2].strip,
                       :poster => File.new(poster))
      end
    end
  end
end
