require 'test_helper'

module Api
  module V1
    module Providers
      module Products
        class ShowProductsTest < Api::ApiIntegrationTest
          let(:user) { create(:user) }
          let(:provider) { create(:provider) }
          let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }
          let(:product) { create(:product, provider: provider)}

          before do
            log_user;

            create_list(:question, 5, product: product)
          end

          def log_user
            user
          end

          it "[Example] returns a list of products of a provider" do
            get_provider_product(product)

            assert_json_match Api::V1::ProductPattern.new(product).pattern, json
          end

          def get_provider_product(product)
            get "/api/v1/providers/#{product.provider.id}/products/#{product.id}"
          end
        end
      end
    end
  end
end
