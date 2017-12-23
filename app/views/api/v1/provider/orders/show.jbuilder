json.partial! 'order', order: @order
json.order_items do
  json.array! @order.order_items.each do |order_item|
    json.partial! 'order_item', order_item: order_item
  end
end
