class Api::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :destroy_session
  before_action :authenticate_action

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  # rescue_from ApplicationError do |exception|
  #   render json: { errors: exception.errors }, status: :unprocessable_entity
  # end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    head :not_found
  end

  def authenticate_action
    authenticate_or_request_with_http_token do |token, options|
      @current_api_token = ApiToken.find_by(token: token)
      @current_api_token.present? && !@current_api_token.expired?
    end
  end

  def current_api_token
    @current_api_token
  end

  def default_serializer_options
    {root: false}
  end

  protected

  def destroy_session
    request.session_options[:skip] = true
  end
end
