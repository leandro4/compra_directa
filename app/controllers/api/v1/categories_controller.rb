class Api::V1::CategoriesController < Api::V1::BaseController
  skip_before_action :authenticate_action, only: [:index]

  api :GET, "/v1/categories", "List all categories"
  def index
    categories = Category.all

    render json: categories
  end
end
