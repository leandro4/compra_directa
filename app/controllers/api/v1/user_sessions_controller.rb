class Api::V1::UserSessionsController < Api::V1::BaseController
  skip_before_action :authenticate_action, only: [:create]

  ####### Api Documentation #########
  api :POST, "/v1/user_session", "Creates a user session"
  param :email, String
  param :password, String
  ###### End of Documentation #######
  def create
    user = User.find_by!(email: login_params[:email])

    if user.authenticate(login_params[:password])
      api_token = user.create_api_token
      render json: { api_token: api_token.token }, status: :ok
    else
      head :unauthorized
    end

  end

  # ####### Api Documentation #########
  # api :DELETE, "/v1/security/security_session", "Destroy a security guard session"
  # ###### End of Documentation #######
  # def destroy
  #   current_user.api_token.destroy
  #   head :ok
  # end

  private

  def login_params
    params.permit(:email, :password)
  end
end