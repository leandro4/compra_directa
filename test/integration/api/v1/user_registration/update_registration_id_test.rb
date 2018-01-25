require 'test_helper'

module Api
  module V1
    module UserRegistration
      class UpdateRegistrationIdTest < Api::ApiIntegrationTest
        let(:user) { create(:commerce) }
        let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

        before do
          log_user
        end

        def log_user
          user
        end

        let(:valid_params) {{
          registration_id: "some_id"
        }}

        context "When the submitted user is valid" do
          it "[Example] returns success" do
            post_user_registration(valid_params)
            assert_response :success
          end

          it "updates a user" do
            post_user_registration(valid_params)

            user.reload

            assert_equal valid_params[:registration_id], user.api_token.registration_id
          end
        end

        context "when the submitted user attributes are not valid" do
          it "[Example] reject invalid user_types" do
            post_user_registration(valid_params.merge(registration_id: ""))
            assert_equal [t("errors.messages.blank")], json["errors"]["registration_id"]
          end
        end

        def post_user_registration(params)
          post "/api/v1/user_registration", params
        end
      end
    end
  end
end
