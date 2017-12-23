class Api::V1::Commerce::QuestionsController < Api::V1::BaseController
  api :GET, "/v1/commerce/questions", "Get a commerce questions"
  def index
    @questions = current_user.questions
  end
end
