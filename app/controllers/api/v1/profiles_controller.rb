class Api::V1::ProfilesController < Api::V1::BaseController

  api :PUT, "/v1/profile", "Update the user profile"
  param :phone, String
  param :address, String
  def update
    current_user.update(user_update_params)
    head :ok
  end

  protected

  def user_update_params
    params.permit(:phone, :address).reject{|_, v| v.blank?}
  end
end
