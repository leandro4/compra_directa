FactoryBot.define do
  factory :user do
    business_name { FFaker::Name.last_name }
    description { FFaker::Name.last_name }
  	email { FFaker::Internet.email }
  	password { FFaker::Internet.password }
    phone { FFaker::PhoneNumber.phone_number }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    cuit "30202020209"
  end
end
