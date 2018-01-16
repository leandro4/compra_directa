class GoogleUserSessionValidator < BaseValidator
  attr_accessor :google_token

  validates :google_token, presence: true
end
