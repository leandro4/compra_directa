class Api::V1::Commerce::DiscountsController < Api::V1::BaseController
  api :GET, "/v1/commerce/discounts", "List a provider discounts"
  param :category, String
  param :page, Integer
  def index
    @products = products.active_discount.page(params[:page])
  end

  protected

  def products
    raise ActiveRecord::RecordNotFound if !Category.all.has_key?(params[:category])

    providers = Provider.where(category: params[:category])

    Product.where(provider: providers)
  end
end
