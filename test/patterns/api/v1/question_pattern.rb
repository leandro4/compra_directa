class Api::V1::QuestionPattern < Pattern
  def initialize(question = nil)
    if question
      @question = question
      @pattern = {
        id: question.id,
        question: question.question,
        answer: question.answer,
        answered_at: l(question.answered_at)
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
      answered_at: l(question.answered_at)
    }
  end
end
