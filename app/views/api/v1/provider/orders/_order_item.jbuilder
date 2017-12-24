json.(order_item, :id, :quantity, :unit_price)
json.product do
  json.partial! 'api/v1/commerce/products/product', product: order_item.product
end
