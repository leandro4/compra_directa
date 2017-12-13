class Order < ApplicationRecord
  belongs_to :commerce
  belongs_to :provider

  has_many :order_items, dependent: :destroy
end
