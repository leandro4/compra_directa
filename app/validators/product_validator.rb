class ProductValidator < BaseValidator
  attr_accessor :name, :description, :price

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
