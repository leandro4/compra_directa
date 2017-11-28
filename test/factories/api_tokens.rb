FactoryBot.define do
  factory :api_token do
    expire_at { FFaker::Time.date }
    token { SecureRandom.urlsafe_base64(64) }
  end
end
