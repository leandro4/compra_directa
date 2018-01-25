class RegistrationIdValidator < BaseValidator
  attr_accessor :registration_id

  validates :registration_id, presence: true
end
