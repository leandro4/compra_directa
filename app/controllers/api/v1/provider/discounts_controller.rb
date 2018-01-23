class Api::V1::Provider::DiscountsController < Api::V1::BaseController
  api :GET, "/v1/provider/discounts", "List provider's discounts"
  param :page, Integer
  def index
    @products = current_user.products.active_discount.page(params[:page])
  end
end
