class Api::V1::Provider::OrdersController < Api::V1::BaseController

  api :GET, "/v1/provider/orders/:id", "Get a provider order"
  def show
    @order = current_user.orders.find(params[:id])
  end

  api :GET, "/v1/provider/orders", "Get a provider order list"
  param :page, Integer
  param :status, String, desc: "One of the list: [#{Order::STATUSES}]"
  def index
    if params[:status].present?
      @orders = current_user.orders.where(status: params[:status]).page(params[:page])
    else
      @orders = current_user.orders.page(params[:page])
    end
  end

  api :POST, "/v1/provider/orders/:id/accept", "Accept a provider order"
  def accept
    order = current_user.orders.find(params[:id])
    order.accept!

    Notifier.new.order_accepted_push(order)

    head :ok
  end

  api :POST, "/v1/provider/orders/:id/reject", "Reject a provider order"
  def reject
    order = current_user.orders.find(params[:id])
    order.reject!

    Notifier.new.order_rejected_push(order)

    head :ok
  end
end
