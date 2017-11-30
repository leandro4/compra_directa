FactoryBot.define do
  factory :product do
    name { "product" }
    description { "a product" }
    price { 10.0 }
    discount_price { 8.5 }
    is_discount false

    provider
  end
end
