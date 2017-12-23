class Api::V1::OrderPattern < Pattern
  def initialize(order = nil)
    if order
      @order = order
      @pattern = {
        id: order.id,
        status: order.status,
        created_at: l(order.created_at),
        items: order.order_items.size,
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
    @pattern.merge!(provider: Api::V1::UserPattern.new(@order.provider).pattern)

    self
  end

  def list_for_provider(orders)
    @pattern = {orders: [], metadata: {current_page: 1, per_page: 30, total_entries: orders.size }}

    orders.each do |order|
      @pattern[:orders] << list_pattern(order).merge(commerce: Api::V1::UserPattern.new(order.commerce).pattern)
    end

    self
  end

  def list_for_commerce(orders)
    @pattern = {orders: [], metadata: {current_page: 1, per_page: 30, total_entries: orders.size }}

    orders.each do |order|
      @pattern[:orders] << list_pattern(order).merge(provider: Api::V1::UserPattern.new(order.provider).pattern)
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
