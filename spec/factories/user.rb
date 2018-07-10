FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street_number 10
    street_name { Faker::Address.street_name }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    email { Faker::Internet.email }
    password 'password'
  end
end
