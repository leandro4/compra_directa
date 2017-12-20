class Api::V1::OrderPattern < Pattern
  def initialize(order = nil)
    if order
      @order = order
      @pattern = {
        id: order.id,
        status: order.status,
        created_at: l(order.created_at),
        order_items: Api::V1::OrderItemPattern.new.list(order.order_items).pattern
      }
    end

    self
  end

  def for_provider
    @pattern.merge!(commerce: Api::V1::UserPattern.new(@order.commerce).pattern)

    self
  end

  def for_commerce
    @pattern.merge!(provider: Api::V1::UserPattern.new(@order.provider).pattern, items: @order.order_items.size)

    self
  end

  def list_for_provider(orders)
    @pattern = []

    orders.each do |order|
      @pattern << list_pattern(order).merge(commerce: Api::V1::UserPattern.new(order.commerce).pattern)
    end

    self
  end

  def list_for_commerce(orders)
    @pattern = []

    orders.each do |order|
      @pattern << list_pattern(order).merge(provider: Api::V1::UserPattern.new(order.provider).pattern)
    end

    self
  end

  def list_pattern(order)
    {
        id: order.id,
        status: order.status,
        created_at: l(order.created_at),
        items: order.order_items.size,
    }
  end
end
