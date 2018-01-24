class Api::V1::ProductPattern < Pattern
  def initialize(product = nil)
    if product
      @product = product
      @pattern = {
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        provider_id: product.provider_id,
        discount_price: product.discount_price,
        is_discount: product.is_discount
      }
    end

    self
  end

  def with_questions
    @pattern.merge!(questions: Api::V1::QuestionPattern.new.list(@product.questions).pattern)

    self
  end

  def list(products)
    @pattern = {products: [], metadata: {current_page: 1, per_page: 30, total_entries: products.size }}

    products.each do |product|
      @pattern[:products] << list_pattern(product)
    end

    self
  end

  def list_discount(products)
    @pattern = {products: [], metadata: {current_page: 1, per_page: 30, total_entries: products.size }}

    products.each do |product|
      @pattern[:products] << list_discount_pattern(product)
    end

    self
  end

  def list_discount_pattern(product)
    {
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      provider_id: product.provider_id,
      discount_price: product.discount_price,
      is_discount: product.is_discount,
      discount_expire_at: l(product.discount_expire_at)
    }
  end

  def list_pattern(product)
    {
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      provider_id: product.provider_id,
      discount_price: product.discount_price,
      is_discount: product.is_discount
    }
  end
end
