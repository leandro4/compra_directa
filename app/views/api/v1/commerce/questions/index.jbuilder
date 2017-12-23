json.array! @questions.each do |question|
  json.partial! 'api/v1/provider/questions/question', question: question
end
