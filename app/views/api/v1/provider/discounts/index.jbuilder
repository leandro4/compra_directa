json.products do
  json.array! @products.each do |product|
    json.partial! 'api/v1/commerce/products/product', product: product
    json.discount_expire_at l(product.discount_expire_at)
  end
end
json.metadata do
  json.current_page @products.current_page
  json.per_page @products.limit_value
  json.total_entries @products.count
end
