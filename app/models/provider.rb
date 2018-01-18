class Provider < User
  has_many :products, dependent: :destroy
  has_many :questions, through: :products
  has_many :orders, dependent: :destroy

  validates :business_name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :iva, presence: true
  validates :cuit, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validate :invalid_category

  def invalid_category
    errors.add(:category, :invalid) if category.present? &&
      !Category.all.has_key?(category)
  end
end
