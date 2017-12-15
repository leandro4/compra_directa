class Question < ApplicationRecord
  belongs_to :commerce
  belongs_to :product

  def provider
    product.provider
  end
end
