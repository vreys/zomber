# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :serial do |f|
  f.title { Faker::Lorem.words(rand(3) + 2).join(' ') }
  f.original_title { Faker::Lorem.words(rand(3) + 2).join(' ') }
  f.description { Faker::Lorem.words(rand(5) + 2).join(' ') }
end
