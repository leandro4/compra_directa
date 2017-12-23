class Commerce < User
  has_many :orders, dependent: :destroy
  has_many :questions, dependent: :destroy
end
