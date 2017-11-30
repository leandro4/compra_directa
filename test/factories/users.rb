FactoryBot.define do
  factory :user do
  	email { FFaker::Internet.email }
  	password { FFaker::Internet.password }
  	first_name { FFaker::Name.first_name }
  	last_name { FFaker::Name.last_name }
    phone { FFaker::PhoneNumber.phone_number }
    address { FFaker::Address.street_address }
  end
end
