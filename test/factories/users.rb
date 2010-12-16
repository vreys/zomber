# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.name { Faker::Name.name  }
  f.email { Faker::Internet.email }
  f.password "123asddsa"
  f.password_confirmation "123asddsa"
end
