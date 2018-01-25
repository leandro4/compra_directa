class Api::V1::Commerce::QuestionsController < Api::V1::BaseController
  api :GET, "/v1/commerce/questions", "Get a commerce questions"
  def index
    @questions = current_user.questions
  end

  api :POST, "/v1/commerce/providers/:provider_id/products/:product_id/questions", "Create a question for a provider's product"
  param :question, String
  ###### End of Documentation #######
  def create
    QuestionValidator.new.validate!(question_params)

    question = current_user.questions.create(question_params.merge(product_id: product.id))

    Notifier.new.new_question_push(question)

    head :ok
  end

  protected

  def product
    Product.find_by(id: params[:product_id], provider_id: params[:provider_id])
  end

  def question_params
    params.permit(:question)
  end
end
