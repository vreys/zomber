class Repository
  class << self
    def index!
      Serial.destroy_all
      
      Dir[Rails.root.join(REPOS_PATH, '**')].each do |dir|
        container = SerialContainer.build(dir)
        Serial.rebuild(container)
      end
    end
  end
end
