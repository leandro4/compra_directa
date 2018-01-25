require 'test_helper'

module Api
  module V1
    module Provider
      module Questions
        class UpdateQuestionTest < Api::ApiIntegrationTest
          let(:provider) { create(:provider) }
          let(:api_token) { create(:api_token, user: provider, expire_at: 1.hour.ago) }
          let(:product) { create(:product, provider: provider )}
          let(:question) { create(:question, product: product )}

          let(:valid_params) {{
            answer: FFaker::Lorem.sentence
          }}

          before do
            log_user;
          end

          def log_user
            provider
          end

          context "With valid params" do
            it "[Example] updated the questions answer" do
              question = create(:question, product: product)

              put_question(question, valid_params)

              assert_equal valid_params[:answer], question.reload.answer
            end

            it "returns 404 for a not logged provider's question" do
              question = create(:question)

              put_question(question, valid_params)

              assert_response :not_found
            end

            it "Sends a push notificacion to logged commerce" do
              create(:api_token, user: question.commerce, expire_at: 1.hour.ago)

              stubed_request = stub_request(:post, "https://fcm.googleapis.com/fcm/send")

              put_question(question, valid_params)

              assert_requested(stubed_request)
            end
          end

          context "With invalid params" do
            it "reject empty answers" do
              put_question(question, valid_params.merge(answer: ""))
              assert_equal [t("errors.messages.blank")], json["errors"]["answer"]
            end
          end

          def put_question(question, params)
            put "/api/v1/provider/questions/#{question.id}", params
          end
        end
      end
    end
  end
end
