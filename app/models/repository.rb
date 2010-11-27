class Repository
  class << self
    def index!
      Dir[Rails.root.join('tmp', 'serials', '**')].each do |dir|
        basename = File.basename(dir)

        meta = File.new(File.join(dir, basename + '.txt'), 'r')
        options = meta.readlines
        meta.close

        Serial.create!(:title => options[0].strip, :slug => options[1].strip)
      end
    end
  end
end
