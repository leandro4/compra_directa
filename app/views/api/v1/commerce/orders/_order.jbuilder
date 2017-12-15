json.(order, :id, :status)
json.items order.order_items.size
json.provider do
  json.partial! 'api/v1/users/user', user: order.provider
end
