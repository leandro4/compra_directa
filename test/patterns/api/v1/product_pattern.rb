class Api::V1::ProductPattern < Pattern
  def initialize(product)
    @product = product
    @pattern = {
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      discount_price: product.discount_price,
      is_discount: product.is_discount
    }

    self
  end
end
