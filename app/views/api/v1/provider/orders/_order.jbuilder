json.(order, :id, :status)
json.created_at l(order.created_at)
json.commerce do
  json.partial! 'api/v1/users/user', user: order.commerce
end
json.order_items do
  json.array! @order.order_items.each do |order_item|
    json.partial! 'order_item', order_item: order_item
  end
end
