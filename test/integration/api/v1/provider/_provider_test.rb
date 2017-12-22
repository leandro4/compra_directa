require 'test_helper'

module Api
  module V1
    module Provider
      class ProviderTest < Api::ApiIntegrationTest
          let(:provider) { create(:provider) }
          let(:api_token) { create(:api_token, user: provider, expire_at: 1.hour.ago) }

          before do
            log_provider;
          end

          def log_provider
            provider
          end
      end
    end
  end
end
