class Api::V1::UserSessionsController < Api::V1::BaseController
  ####### Api Documentation #########
  api :DELETE, "/v1/user_session", "Destroy user session"
  ###### End of Documentation #######
  def destroy
    current_user.api_token.destroy

    head :ok
  end

end
