class Api::V1::Commerce::ProvidersController < Api::V1::BaseController
  api :GET, "/v1/commerce/providers", "List all providers"
  param :category, String
  ###### End of Documentation #######
  def index
    @providers = Provider.where(category: params[:category])
  end
end
