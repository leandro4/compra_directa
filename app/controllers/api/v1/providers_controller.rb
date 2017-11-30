class Api::V1::ProvidersController < Api::V1::BaseController
  api :GET, "/v1/providers", "List all providers"
  ###### End of Documentation #######
  def index
    @providers = Provider.all
  end
end
