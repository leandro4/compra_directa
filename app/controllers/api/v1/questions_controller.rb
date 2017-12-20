class Api::V1::QuestionsController < Api::V1::BaseController
  api :POST, "/v1/provider/:provider_id/products/:product_id/questions", "Create a question for a provider's product"
  param :question, String
  ###### End of Documentation #######
  def create
    Validators::QuestionValidator.new.validate!(question_params)

    product.questions.create!(question_params)

    head :ok
  end

  protected

  def product
    Product.where(id: params[:product_id], provider_id: params[:provider_id]).first
  end

  def question_params
    params.permit(:question)
  end
end
