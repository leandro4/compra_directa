json.orders do
  json.array! @orders.each do |order|
    json.partial! 'order', order: order
  end
end
json.metadata do
  json.current_page @orders.current_page
  json.per_page @orders.limit_value
  json.total_entries @orders.count
end
