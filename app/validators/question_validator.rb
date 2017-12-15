module Validators
  class QuestionValidator < BaseValidator
    attr_accessor :question

    validates :question, presence: true
  end
end
