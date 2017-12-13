class Commerce < User
  has_many :orders, dependent: :destroy
end
