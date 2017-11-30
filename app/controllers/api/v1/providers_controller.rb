class Api::V1::ProvidersController < Api::V1::BaseController
  api :GET, "/v1/providers", "List all providers"
  param :category, String
  ###### End of Documentation #######
  def index
    @providers = Provider.where(category: params[:category])
  end
end
