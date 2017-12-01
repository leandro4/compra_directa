class Api::V1::UserRegistrationsController < Api::V1::BaseController
  # include Concerns::ImageUploaderController

  ####### Api Documentation #########
  api :put, "/v1/user_registration", "Update a new user"
  param :first_name, String
  param :last_name, String
  param :phone, String
  param :address, String
  param :category, String
  param :user_type, String
  ###### End of Documentation #######
  def update
    Validators::CreateUserValidator.new.validate!(registration_params)

    current_user.completed = true
    current_user.type = params.delete(:user_type).camelize
    current_user.update!(registration_params)

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
    params.permit(:first_name, :last_name, :phone, :address, :user_type,
      :category, :iva)
  end
end
