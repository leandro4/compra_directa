class AnswerValidator < BaseValidator
  attr_accessor :answer

  validates :answer, presence: true
end
