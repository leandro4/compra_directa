class User < ApplicationRecord
  COMMERCE = "commerce"
  PROVIDER = "provider"

  USER_TYPES = [COMMERCE, PROVIDER]

  has_secure_password(validations: false)

  has_one :api_token, dependent: :destroy, as: :user

  mount_base64_uploader :avatar, AvatarUploader

  def self.find_google_user(profile)
    where("google_id = ? OR email = ?", profile["google_id"], profile["email"]).first
  end
end
