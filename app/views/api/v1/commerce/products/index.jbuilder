json.products do
  json.array! @products.each do |product|
    json.partial! 'product', product: product
  end
end
json.metadata do
  json.current_page @products.current_page
  json.per_page @products.limit_value
  json.total_entries @products.count
end
