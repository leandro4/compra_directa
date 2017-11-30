class Api::V1::UserRegistrationsController < Api::V1::BaseController
  # include Concerns::ImageUploaderController
  skip_before_action :authenticate_action, only: [:create]

  ####### Api Documentation #########
  api :POST, "/v1/user_registration", "Register an user"
  param :first_name, String
  param :last_name, String
  param :phone, String
  param :address, String
  param :category, String
  param :user_type, String
  param :email, String
  param :password, String
  ###### End of Documentation #######
  def create
    Validators::CreateUserValidator.new.validate!(registration_params)

    user_type = params.delete(:user_type).camelize.constantize
    @user = user_type.create!(registration_params)

    # begin
    #   params[:avatar] = parse_image_data(params[:avatar]) if params[:avatar]
    #   @user = current_device.create_user!(registration_params)
    # ensure
    #   clean_tempfile
    # end
    head :ok
  end

  protected

  def registration_params
    # params.permit(:first_name, :last_name, :email, :uid, :uid_type, :avatar)
    params.permit(:first_name, :last_name, :email, :password, :phone, :address,
      :user_type, :category)
  end
end
