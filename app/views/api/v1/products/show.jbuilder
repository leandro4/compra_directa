json.partial! 'product', product: @product

json.questions do
  json.array! @product.questions.each do |question|
    json.id question.id
    json.question question.question
    json.answer question.answer
    json.answered_at question.answered_at ? l(question.answered_at) : nil
  end
end
