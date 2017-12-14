class Api::V1::OrderItemPattern < Pattern
  def initialize(order_item = nil)
    if order_item
      @order_item = order_item
      @order_item = {
        id: order_item.id,
        quantity: order_item.quantity,
        unit_price: order_item.unit_price,
        product: Api::V1::ProductPattern.new(order_item.product).pattern
      }
    end

    self
  end

  def list(order_items)
    @pattern = []

    order_items.each do |order_item|
      @pattern << list_pattern(order_item)
    end

    self
  end

  def list_pattern(order_item)
    {
      id: order_item.id,
      quantity: order_item.quantity,
      unit_price: order_item.unit_price,
      product: Api::V1::ProductPattern.new(order_item.product).pattern
    }
  end
end
