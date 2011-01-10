# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.email { Faker::Internet.email }
  f.login { Faker::Name.name }
  f.password "123asddsa"
  f.password_confirmation "123asddsa"
end
