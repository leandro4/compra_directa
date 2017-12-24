class Api::V1::Commerce::ProductsController < ApplicationController
  api :GET, "/v1/commerce/provider/:provider_id/products/:id", "Show a provider product"
  def show
    @product = provider.products.find(params[:id])
  end

  api :GET, "/v1/commerce/provider/:provider_id/products", "List a provider products"
  param :page, Integer
  def index
    @products = provider.products.paginate(page: params[:page])
  end

  protected

  def provider
    ::Provider.find(params[:provider_id])
  end
end
