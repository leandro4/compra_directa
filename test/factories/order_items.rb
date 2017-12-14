FactoryBot.define do
  factory :order_item do
    product
    unit_price { product.price }
    quantity 1
  end
end
