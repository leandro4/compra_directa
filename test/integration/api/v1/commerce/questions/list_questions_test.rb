require 'test_helper'

module Api
  module V1
    module Commerce
      module Questions
        class ListQuestionsTest < Api::V1::Commerce::CommerceTest
          let(:questions) { create_list(:question, 5, answer: nil, commerce: commerce) }
          let(:answered_questions) { create_list(:question, 5, commerce: commerce) }

          before do
            questions; answered_questions
          end


          it "[Example] returns a list of unanswered questions" do
            get_questions

            assert_json_match Api::V1::QuestionPattern.new.list(questions + answered_questions).pattern, json
          end

          def get_questions
            get "/api/v1/commerce/questions"
          end
        end
      end
    end
  end
end
