json.(order, :id, :status)
json.created_at l(order.created_at)
json.items order.order_items.size
json.commerce do
  json.partial! 'api/v1/users/user', user: order.commerce
end
