class Api::V1::UsersController < Api::V1::BaseController
  api :GET, "/v1/users/:id", "Show an user info"
  def show
    @user = User.find(params[:id])
  end
end
