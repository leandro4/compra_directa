class Question < ApplicationRecord
  belongs_to :commerce
  belongs_to :product

  scope :unanswered, -> { where(answer: nil) }

  def provider
    product.provider
  end
end
