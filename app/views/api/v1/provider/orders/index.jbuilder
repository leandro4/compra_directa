json.orders do
  json.array! @orders.each do |order|
    json.partial! 'order', order: order
  end
end

json.metadata do
  json.current_page @orders.current_page
  json.per_page @orders.per_page
  json.total_entries @orders.total_entries
end
