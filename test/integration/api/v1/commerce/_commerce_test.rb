require 'test_helper'

module Api
  module V1
    module Commerce
      class CommerceTest < Api::ApiIntegrationTest
        let(:commerce) { create(:commerce) }
        let(:api_token) { create(:api_token, user: commerce, expire_at: 1.hour.ago) }

        before do
          log_commerce
        end

        def log_commerce
          commerce
        end
      end
    end
  end
end
