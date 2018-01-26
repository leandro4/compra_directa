require 'test_helper'

module Api
  module V1
    module UserSession
      class DestroySessionTest < Api::ApiIntegrationTest
        let(:user) { create(:commerce) }
        let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

        before do
          log_user
        end

        def log_user
          user
        end

        it "destroy the user api token" do
          delete_user_session

          assert_nil user.reload.api_token
        end

        def delete_user_session
          delete("/api/v1/user_session")
        end
      end
    end
  end
end
