json.array! @questions.each do |question|
  json.partial! 'question', question: question
end
