class Repository
  class << self
    def index!
      Serial.destroy_all
      
      Dir[Rails.root.join(REPOS_PATH, '*')].each do |dir|
        container = SerialContainer.new(dir)
        
        Serial.import!(container)
      end
    end
  end
end
