FactoryBot.define do
  factory :product do
    name { "product" }
    description { "a product" }
    price { 10.0 }
    discount_price { 8.5 }
    discount_expire_at { 10.days.from_now }
    is_discount false

    provider
  end
end
