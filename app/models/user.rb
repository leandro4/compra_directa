class User < ApplicationRecord
  has_secure_password(validations: false)

  has_one :api_token, dependent: :destroy
end
