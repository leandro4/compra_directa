class Api::V1::ProvidersController < Api::V1::BaseController
  def index
    @providers = User.providers
  end
end
