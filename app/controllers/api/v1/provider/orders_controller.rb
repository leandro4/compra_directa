class Api::V1::Provider::OrdersController < Api::V1::BaseController

  api :GET, "/v1/provider/orders/:id", "Get a provider order"
  def show
    @order = current_user.orders.find(params[:id])
  end

  api :POST, "/v1/provider/orders/:id/accept", "Accept a provider order"
  def accept
    order = current_user.orders.find(params[:id])
    order.accept!

    head :ok
  end

  api :POST, "/v1/provider/orders/:id/reject", "Reject a provider order"
  def reject
    order = current_user.orders.find(params[:id])
    order.reject!

    head :ok
  end
end
