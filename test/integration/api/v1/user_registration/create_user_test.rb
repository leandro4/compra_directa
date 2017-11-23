require 'test_helper'

module Api
  module V1
    module UserRegistration
      class CreateUserTest < Api::ApiIntegrationTest
        let(:api_token) { Fabricate(:api_token, expire_at: 1.hour.ago, api_authenticable: device) }

        let(:valid_params) {{
          first_name: FFaker::Name.first_name,
          last_name: FFaker::Name.last_name,
          email: FFaker::Internet.email,
          password: "password"
          # avatar:  {
          #   filename: "ruby.jpg",
          #   content: base64_open(File.join(Rails.root, 'test', 'support', 'files', 'ruby.jpg')),
          #   content_type: "image/jpg"
          # }
        }}

        context "When the submitted user is valid" do
          it "[Example] returns success" do
            post_user_registration(valid_params)
            assert_response :success
          end

          it "creates a user" do
            assert_difference 'User.count' do
              post_user_registration(valid_params)
            end
          end
        end

        context "when the submitted user attributes are not valid" do
          it "reject invalid emails" do
            post_user_registration(valid_params.merge(email: "some@"))
            assert_equal [t("errors.attributes.email.invalid")], json["errors"]["email"]
          end

          [:email, :first_name, :last_name].each do |field|
            it "reject missing #{field}" do
              valid_params[field] = ""
              post_user_registration(valid_params)
              assert_equal [t("errors.messages.blank")], json["errors"][field.to_s]
            end
          end
        end

        def post_user_registration(params)
          post "/api/v1/user_registration", params
        end
      end
    end
  end
end
