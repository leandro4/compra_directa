json.(question, :id, :question, :answer)
json.answered_at question.answered_at ? l(question.answered_at) : nil
