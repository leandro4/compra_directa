class Api::V1::ProductsController < Api::V1::BaseController
  api :GET, "/v1/provider/:provider_id/products", "List a provider products"
  def index
    @products = Provider.find(params[:provider_id]).products
  end
end
