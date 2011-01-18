Factory.define :episode do |f|
  f.title { Faker::Lorem.words(rand(3) + 2).join(' ') }
  f.original_title { Faker::Lorem.words(rand(3) + 2).join(' ') }
end
