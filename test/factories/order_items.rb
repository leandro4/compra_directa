FactoryBot.define do
  factory :order_item do
    product
    unit_price { product.price }
    product_name { product.name }
    product_description { product.description }
    quantity 1
  end
end
