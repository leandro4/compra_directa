class Provider < User
  has_many :products, dependent: :destroy
end
