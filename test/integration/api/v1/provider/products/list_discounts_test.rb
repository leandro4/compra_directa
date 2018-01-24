require 'test_helper'

module Api
  module V1
    module Commerce
      module Products
        class ListDiscountsTest < Api::ApiIntegrationTest
          let(:user) { create(:provider) }
          let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

          let(:products) { create_list(:product, 5, provider: user)}
          let(:active_discounts) { create_list(:product, 5, provider: user, is_discount: true )}
          let(:expired_discounts) { create_list(:product, 5, provider: user, is_discount: true, discount_expire_at: 1.day.ago )}

          before do
            log_user; products; active_discounts; expired_discounts
          end

          def log_user
            user
          end

          it "[Example] returns a list of products of a provider" do
            get_provider_discounts

            assert_json_match Api::V1::ProductPattern.new.list_discount(active_discounts).pattern, json
          end

          def get_provider_discounts
            get "/api/v1/provider/discounts"
          end
        end
      end
    end
  end
end
