class CreateUserValidator < BaseValidator
  attr_accessor :business_name, :description, :phone, :address, :user_type,
    :category, :iva, :city, :cuit

  validates :business_name, presence: true
  validates :user_type, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :iva, presence: true
  validates :cuit, presence: true
  validates :category, presence: true, if: Proc.new { user_type == User::PROVIDER }
  validates :description, presence: true, if: Proc.new {user_type == User::PROVIDER }
  validate :invalid_user_type
  validate :invalid_category

  def invalid_user_type
    errors.add(:user_type, :invalid) if user_type.present? &&
      !User::USER_TYPES.include?(user_type)
  end

  def invalid_category
    errors.add(:category, :invalid) if category.present? &&
      !Category.all.has_key?(category)
  end
end
