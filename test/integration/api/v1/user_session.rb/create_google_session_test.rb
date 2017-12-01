require 'test_helper'

module Api
  module V1
    module UserSession
      class CreateGoogleSessionTest < Api::ApiIntegrationTest
        describe "create" do
          context "When google authenticates" do
            let(:request_response) { { "email"=>"sudo.juan@gmail.com",
              "kid"=>"some_id",
              "picture" => "picture_url",
              "given_name" => "Juan Manuel",
              "family_name" => "Costello" }}

            before do
              stub_request(:get, /https:\/\/www\.googleapis\.com\/oauth2\/v3\/tokeninfo.*/).
              to_return(body: request_response.to_json)
            end

            context "and the user doens't exist" do
              test "it creates a user" do
                assert_difference("::User.count", 1) do
                  valid_post_user_session
                end
              end

              test "[Example] returns the api token" do
                valid_post_user_session

                refute_nil json["token"]
              end
            end

            context "when the user exist" do
              let(:user) { create(:user, google_id: request_response["kid"], api_token: nil) }

              test "returns the api token" do
                valid_post_user_session

                refute_nil json["token"]
              end
            end

            context "when the user exist with same email" do
              let(:user) { create(:user, email: request_response["email"], api_token: nil)}

              before do
                user
              end

              test "creates a new api token for the user if he didnt have one" do
                assert_nil(user.api_token, "Expected to not have an api_token")

                valid_post_user_session

                refute_nil(user.reload.api_token, "Expected to have an api_token")
              end

              test "associates user with google" do
                valid_post_user_session
                assert_equal("some_id", user.reload.google_id)
              end

              test "returns the api token" do
                valid_post_user_session

                refute_nil json["token"]
              end
            end

            def valid_post_user_session
              post_user_session(google_token: "valid")
            end

            context "with invalid attributes" do
              test "[Example] reject blank google_token" do
                post_user_session(google_token: "")
                assert_equal([t("errors.messages.blank")], json["errors"]["google_token"])
              end
            end
          end
        end

        context "When the user doens't authenticate" do
          before do
            stub_request(:get, /https:\/\/www\.googleapis\.com\/oauth2\/v3\/tokeninfo.*/).
            to_return(body: '{ "error_description": "Invalid Value" }', status: 400)
          end

          test "[Example] returns invalid fb token" do
            post_user_session(google_token: "invalid")
            assert_equal(t("errors.google_token.invalid"), json["errors"]["base"])
          end
        end

        def post_user_session(params)
          post("/api/v1/user_session/google", params)
        end
      end
    end
  end
end
