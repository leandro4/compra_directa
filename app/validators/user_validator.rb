module Validators
  class UserValidator < BaseValidator
    attr_accessor :first_name, :last_name, :email, :password

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true
    validates :email, presence: true, email: true
  end
end
