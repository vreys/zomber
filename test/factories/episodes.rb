# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :episode do |f|
  index = rand(17)+1
  path = File.join(REPOS_PATH, Faker::Lorem.words(rand(3)+1).join('-'), "season_#{rand(7)+1}", "episode_#{index}").to_s
  
  f.season {|e| e.association(:season)}
  f.index index
  f.webm path + '.webm'
  f.mp4 path + '.mp4'
end
