class Api::V1::Provider::QuestionsController < Api::V1::BaseController
  api :PUT, "/v1/provider/questions/:id", "Answers a provider question"

  def update
    Validators::AnswerValidator.new.validate!(question_params)

    question = current_user.questions.find(params[:id])
    question.update(question_params)
    head :ok
  end

  protected

  def question_params
    params.permit(:answer)
  end
end
