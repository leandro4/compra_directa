require 'test_helper'

module Api
  module V1
    module UserRegistration
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
          business_name: FFaker::Name.last_name,
          phone: FFaker::PhoneNumber.phone_number,
          address: FFaker::Address.street_address,
          city: FFaker::Address.city,
          user_type: User::PROVIDER,
          category: Category.all.first[0],
          iva: "21%",
          cuit: "123456"
          # avatar:  {
          #   filename: "ruby.jpg",
          #   content: base64_open(File.join(Rails.root, 'test', 'support', 'files', 'ruby.jpg')),
          #   content_type: "image/jpg"
          # }
        }}

        context "When the submitted user is valid" do
          it "[Example] returns success" do
            put_user_registration(valid_params)
            assert_response :success
          end

          it "updates a user" do
            put_user_registration(valid_params)
            user.reload

            assert_equal valid_params[:business_name], user.business_name

            assert user.completed?
          end
        end

        context "when the submitted user attributes are not valid" do
          it "reject invalid user_types" do
            put_user_registration(valid_params.merge(user_type: "some"))
            assert_equal [t("errors.messages.invalid")], json["errors"]["user_type"]
          end

          it "reject invalid category" do
            put_user_registration(valid_params.merge(category: "some"))
            assert_equal [t("errors.messages.invalid")], json["errors"]["category"]
          end

          [:business_name, :phone, :address, :city, :user_type,
            :category, :iva, :cuit].each do |field|
            it "reject missing #{field}" do
              valid_params[field] = ""
              put_user_registration(valid_params)
              assert_equal [t("errors.messages.blank")], json["errors"][field.to_s]
            end
          end
        end

        def put_user_registration(params)
          put "/api/v1/user_registration", params
        end
      end
    end
  end
end
