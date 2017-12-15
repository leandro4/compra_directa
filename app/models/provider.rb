class Provider < User
  has_many :products, dependent: :destroy
  has_many :questions, through: :products
  has_many :orders, dependent: :destroy
end
