module HasToken
  extend ActiveSupport::Concern

  included do
    before_create :generate_authentication_token
  end

  protected

  def generate_authentication_token
    authentication_token = nil

    loop do
      authentication_token = SecureRandom.urlsafe_base64(64)
      break unless ApiToken.find_by(token: authentication_token)
    end

    self.token = authentication_token
  end
end