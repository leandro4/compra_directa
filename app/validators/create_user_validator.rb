module Validators
  class CreateUserValidator < BaseValidator
    attr_accessor :first_name, :last_name, :phone, :address, :user_type,
      :category, :iva, :city, :cuit

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :user_type, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :city, presence: true
    validates :category, presence: true
    validates :iva, presence: true
    validates :cuit, presence: true
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
end
