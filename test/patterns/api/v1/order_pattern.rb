class Api::V1::OrderPattern < Pattern
  def initialize(order)
    @order = order
    @pattern = {
      id: order.id,
      status: order.status,
      commerce: Api::V1::UserPattern.new(order.commerce).pattern,
      order_items: Api::V1::OrderItemPattern.new.list(order.order_items).pattern
    }

    self
  end
end
