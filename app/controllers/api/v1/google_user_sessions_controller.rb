require 'net/http'

class Api::V1::GoogleUserSessionsController < Api::V1::BaseController
  skip_before_action :authenticate_action, only: [:create]

  ####### Api Documentation #########
  api :POST, "/v1/user_session/google", "Create an user session with Google credentials"
  param :google_token, String
  ###### End of Documentation #######
  def create
    Validators::GoogleUserSessionValidator.new.validate!(authentication_params)

    profile = authenticate(authentication_params)
    user = User.find_google_user(profile)
    user = create_user(profile) unless user
    user.google_id = profile["kid"] if user.google_id.nil?
    user.save!(user)

    @api_token = user.create_api_token!
  end

  protected

  def create_user(profile)
    profile["google_id"] = profile.delete("kid")
    attributes = profile.slice("email", "google_id")
    # attributes["profile_picture_url"] = profile["picture"]
    user = User.create!(attributes)
    user
  end

  def authenticate(authentication_params)
    response = Net::HTTP.get_response(google_uri(authentication_params[:google_token]))
    raise NonAuthenticatedGoogleUserError.new if response.code.to_i == 400
    JSON.parse(response.body)
  end

  def google_uri(google_token)
    URI("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{google_token}")
  end

  def authentication_params
    params.permit(:google_token)
  end
end
