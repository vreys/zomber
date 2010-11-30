# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :episode do |f|
  f.season_id 1
  f.index 1
  f.webm '/opt/videos/serial/season/episode.webm'
  f.mp4 '/opt/videos/seriak/season/episode.mp4'
end
