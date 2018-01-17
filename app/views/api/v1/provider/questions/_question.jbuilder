json.(question, :id, :question, :answer)
json.provider do
  json.id question.product.provider.id
  json.business_name question.product.provider.business_name
end
json.commerce do
  json.id question.commerce.id
  json.business_name question.commerce.business_name
end
json.product do
  json.id question.product.id
  json.name question.product.name
  json.description question.product.description
end
json.answered_at question.answered_at ? l(question.answered_at) : nil
json.created_at l(question.created_at)
