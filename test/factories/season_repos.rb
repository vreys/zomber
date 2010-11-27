module SeasonRepoFactory
  def self.create(serial_path, index)
    serial_path = File.join(REPOS_PATH, Faker::Lorem.words(rand(3)+2).join('-')).to_s if serial_path.nil?
    path = File.join(serial_path, "season #{index}").to_s

    FileUtils.makedirs(path)

    path
  end
end
