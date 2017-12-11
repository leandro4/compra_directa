class Product < ApplicationRecord
  belongs_to :provider

  has_many :questions
end
