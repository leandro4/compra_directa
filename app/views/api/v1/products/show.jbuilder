json.partial! 'product', product: @product

json.questions do
  json.array! @product.questions.each do |question|
    json.partial! 'api/v1/provider/questions/question', question: question
  end
end
