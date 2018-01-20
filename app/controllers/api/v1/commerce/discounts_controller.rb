class Api::V1::Commerce::DiscountsController < ApplicationController
  api :GET, "/v1/commerce/provider/:provider_id/discounts", "List a provider discounts"
  param :page, Integer
  def index
    @products = provider.products.active_discount.page(params[:page])
  end

  protected

  def provider
    ::Provider.find(params[:provider_id])
  end
end
