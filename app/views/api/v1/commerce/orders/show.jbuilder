json.partial! 'order', order: @order
json.order_items do
  json.array! @order.order_items.each do |order_item|
    json.partial! 'api/v1/provider/orders/order_item', order_item: order_item
  end
end
