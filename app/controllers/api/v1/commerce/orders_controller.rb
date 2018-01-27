class Api::V1::Commerce::OrdersController < Api::V1::BaseController

  api :POST, "/v1/commerce/orders", "List a commerce created orders"
  param :page, Integer
  def index
    @orders = current_user.orders.page(params[:page])
  end

  api :GET, '/v1/commerce/orders/:id', 'Show a commerce order'
  def show
    @order = current_user.orders.find(params[:id])
  end

  api :POST, "/v1/commerce/providers/:provider_id/orders", "Creates an order for a provider"
  param :order, Array, of: Hash do
    param :product_id, String
    param :quantity, Integer
  end
  def create
    raise NoProductsError.new if order_params[:order].empty?

    ActiveRecord::Base.transaction do
      order = provider.orders.create(commerce_id: current_user.id)

      order_params[:order].each do |order_param|
        OrderItemValidator.new.validate!(order_param.merge(provider_id: provider.id))

        product = provider.products.find(order_param[:product_id])
        order.order_items.create(product_id: product.id, quantity: order_param[:quantity],
          unit_price: product.price)
      end

      Notifier.new.order_requested_push(order)

      AdminMailer.new_order(order).deliver
    end

    head :ok
  end

  protected

  def provider
    @provider ||= Provider.find(params[:provider_id])
  end

  def order_params
    params.permit(order: [:product_id, :quantity])
  end
end
