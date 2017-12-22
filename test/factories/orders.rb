FactoryBot.define do
  factory :order do
    status { Order::PENDING }
    commerce
    provider

    after :create do |order|
      product = create(:product, provider: order.provider)
      create_list(:order_item, 4, order: order, product: product)
    end
  end
end
