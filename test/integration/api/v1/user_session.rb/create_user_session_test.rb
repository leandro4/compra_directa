require 'test_helper'

module Api
  module V1
    module UserSession
      class CreateUserSessionTest < Api::ApiIntegrationTest
        let(:user) { create(:user, api_token: nil) }

        let(:valid_params) {{
          email: user.email,
          password: user.password
        }}

        context "when email is valid" do
          context "and password is valid" do
            it "[Example] Return the new api_token" do
              post_user_session(valid_params)
              assert(json["api_token"])
            end

            it "Creates an api token" do
              post_user_session(valid_params)
              refute_nil user.reload.api_token
            end
          end

          context "and password is invalid" do
            it "[Example] return a 401" do
              valid_params[:password] = 'invalid'
              post_user_session(valid_params)
              assert_response :unauthorized
            end
          end
        end

        context "when email is invalid" do
          it "[Example] return a 404" do
            valid_params[:email] = 'invalid_user'
            post_user_session(valid_params)
            assert_response :not_found
          end
        end

        def post_user_session(params)
          post("/api/v1/user_session", email: params[:email], password: params[:password])
        end
      end
    end
  end
end
