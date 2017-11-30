class User < ApplicationRecord
  COMMERCE = "commerce"
  PROVIDER = "provider"

  USER_TYPES = [COMMERCE, PROVIDER]

  has_secure_password(validations: false)

  has_one :api_token, dependent: :destroy, as: :user
end
