json.array! @products.each do |product|
  json.partial! 'product', product: product
end
