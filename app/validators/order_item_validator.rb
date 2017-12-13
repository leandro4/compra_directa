module Validators
  class OrderItemValidator < BaseValidator
    attr_accessor :provider_id, :product_id, :quantity

    validates :quantity, numericality: { greater_than: 0 }
    validate :valid_product

    protected

    def valid_product
      product = Product.where(id: product_id, provider_id: provider_id).first
      errors.add(:product_id, :not_found) unless product
    end
  end
end
