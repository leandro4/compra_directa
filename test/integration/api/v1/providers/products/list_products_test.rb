require 'test_helper'

module Api
  module V1
    module Providers
      module Products
        class ListProductsTest < Api::ApiIntegrationTest
          let(:user) { create(:user) }
          let(:provider) { create(:provider) }
          let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }
          let(:products) { create_list(:product, 5, provider: provider)}

          before do
            log_user; products
          end

          def log_user
            user
          end

          it "[Example] returns a list of products of a provider" do
            get_provider_products(provider)

            assert_json_match Api::V1::ProductPattern.new(products.last).pattern, json.last
          end

          def get_provider_products(provider)
            get "/api/v1/providers/#{provider.id}/products"
          end
        end
      end
    end
  end
end
