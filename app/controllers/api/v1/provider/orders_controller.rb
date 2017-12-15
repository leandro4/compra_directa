class Api::V1::Provider::OrdersController < Api::V1::BaseController
  api :GET, "/v1/provider/orders/:id", "Get a provider order"

  def show
    @order = current_user.orders.find(params[:id])
  end
end
