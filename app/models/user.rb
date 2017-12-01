class User < ApplicationRecord
  COMMERCE = "commerce"
  PROVIDER = "provider"

  USER_TYPES = [COMMERCE, PROVIDER]

  has_secure_password(validations: false)

  has_one :api_token, dependent: :destroy, as: :user

  def self.find_google_user(profile)
    where("google_id = ? OR email = ?", profile["kid"], profile["email"]).first
  end
end
