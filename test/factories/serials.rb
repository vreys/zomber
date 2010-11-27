# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :serial do |f|
  f.title Faker::Lorem.words(rand(5)+1).join(' ')
  f.slug Faker::Lorem.words(rand(3)+2).join('-')
end
