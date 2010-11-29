# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :serial do |f|
  f.title Faker::Lorem.words(rand(5)+1).join(' ')
  f.slug Faker::Lorem.words(rand(3)+2).join('-')
  f.description Faker::Lorem.words(rand(10)+5).join(' ')
  f.poster File.new(Rails.root.join('test', 'factories', 'poster.jpg'))
  f.thumbnail File.new(Rails.root.join('test', 'factories', 'thumbnail.jpg'))
end
