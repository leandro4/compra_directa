json.(question, :id, :question, :answer, :product_id)
json.answered_at question.answered_at ? l(question.answered_at) : nil
json.created_at l(question.created_at)
