class Api::V1::QuestionPattern < Pattern
  def initialize(question = nil)
    if question
      @question = question
      @pattern = {
        id: question.id,
        question: question.question,
        product_id: question.product_id,
        commerce_id: question.commerce_id,
        answer: question.answer,
        answered_at: l(question.answered_at),
        created_at: l(question.created_at)
      }
    end

    self
  end

  def list(questions)
    @pattern = []

    questions.each do |question|
      @pattern << list_pattern(question)
    end

    self
  end

  def list_pattern(question)
    {
      id: question.id,
      question: question.question,
      product_id: question.product_id,
      commerce_id: question.commerce_id,
      answer: question.answer,
      answered_at: l(question.answered_at),
      created_at: l(question.created_at)
    }
  end
end
