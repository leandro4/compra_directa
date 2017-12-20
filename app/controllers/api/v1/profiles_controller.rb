class Api::V1::ProfilesController < Api::V1::BaseController

  api :PUT, "/v1/profile", "Update the user profile"
  param :description, String
  param :phone, String
  param :address, String
  param :city, String
  def update
    current_user.update(user_update_params)
    head :ok
  end

  protected

  def user_update_params
    params.permit(:phone, :address, :description, :city).reject{|_, v| v.blank?}
  end
end
