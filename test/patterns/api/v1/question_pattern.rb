class Api::V1::QuestionPattern < Pattern
  def initialize(question = nil)
    if question
      @question = question
      @pattern = {
        id: question.id,
        question: question.question,
        answer: question.answer,
        answered_at: l(question.answered_at),
        created_at: l(question.created_at),
        product: {
          id: question.product.id,
          name: question.product.name,
          description: question.product.description
        },
        provider: {
          id: question.product.provider.id,
          business_name: question.product.provider.business_name
        },
        commerce: {
          id: question.commerce.id,
          business_name: question.commerce.business_name
        }
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
      answer: question.answer,
      answered_at: l(question.answered_at),
      created_at: l(question.created_at),
      product: {
        id: question.product.id,
        name: question.product.name,
        description: question.product.description
      },
      provider: {
        id: question.product.provider.id,
        business_name: question.product.provider.business_name
      },
      commerce: {
        id: question.commerce.id,
        business_name: question.commerce.business_name
      }
    }
  end
end
