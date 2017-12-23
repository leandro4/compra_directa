require 'test_helper'

module Api
  module V1
    module Provider
      module Questions
        class ListQuestionsTest < Api::V1::Provider::ProviderTest
          let(:product) { create(:product, provider: provider )}
          let(:questions) { create_list(:question, 5, product: product, answer: nil )}
          let(:answered_questions) { create_list(:question, 5, product: product )}

          before do
            questions; answered_questions
          end


          it "[Example] returns a list of unanswered questions" do
            get_questions

            assert_json_match Api::V1::QuestionPattern.new.list(questions).pattern, json
          end

          def get_questions
            get "/api/v1/provider/questions"
          end
        end
      end
    end
  end
end
