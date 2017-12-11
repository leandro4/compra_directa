require 'test_helper'

module Api
  module V1
    module Users
      class GetUserTest < Api::ApiIntegrationTest
        let(:user) { create(:user) }
        let(:another_user) { create(:user) }
        let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

        before do
          log_user
        end

        def log_user
          user
        end

        it "return the user" do
          get_user(another_user.id)

          assert_json_match Api::V1::UserPattern.new(another_user).pattern, json
        end

        def get_user(id)
          get "/api/v1/users/#{id}"
        end
      end
    end
  end
end
