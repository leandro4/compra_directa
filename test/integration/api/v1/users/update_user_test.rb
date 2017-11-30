require 'test_helper'

module Api
  module V1
    module Users
      class UpdateUserTest < Api::ApiIntegrationTest
        let(:user) { create(:user) }
        let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

        before do
          log_user
        end

        def log_user
          user
        end

        let(:valid_params) {{
          phone: FFaker::PhoneNumber.phone_number,
          address: FFaker::Address.street_address,
          # avatar:  {
          #   filename: "ruby.jpg",
          #   content: base64_open(File.join(Rails.root, 'test', 'support', 'files', 'ruby.jpg')),
          #   content_type: "image/jpg"
          # }
        }}

        context "When the submitted user is valid" do
          it "[Example] returns success" do
            puts_users(valid_params)
            assert_response :success
          end

          it "update a user" do
            puts_users(valid_params)

            user.reload
            assert_equal valid_params[:phone], user.phone
            assert_equal valid_params[:address], user.address
          end
        end

        context "when the submitted user attributes are not valid" do
          [:phone, :address].each do |field|
            it "ignore blank #{field}" do
              valid_params[field] = ""
              puts_users(valid_params)

              refute_equal valid_params[field], user.reload.phone
            end
          end

          [:email, :first_name, :last_name, :user_type].each do |field|
            it "reject #{field} update" do
              valid_params[field] = "some_value"
              puts_users(valid_params)

              refute_equal valid_params[field], user.reload.phone
            end
          end
        end

        def puts_users(params)
          put "/api/v1/users", params
        end
      end
    end
  end
end
