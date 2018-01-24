require 'test_helper'

module Api
  module V1
    module Providers
      module Products
        class ListDiscountsTest < Api::ApiIntegrationTest
          let(:user) { create(:provider) }
          let(:api_token) { create(:api_token, user: user, expire_at: 1.hour.ago) }

          let(:provider) { create(:provider) }
          let(:another_provider) { create(:provider, category: provider.category) }

          let(:active_discounts) { create_list(:product, 5, provider: provider, is_discount: true )}
          let(:another_active_discounts) { create_list(:product, 5, provider: another_provider, is_discount: true )}

          before do
            log_user; active_discounts; another_active_discounts;

            another_category_provider = create(:provider, category: Category.all.keys.last)
            create_list(:product, 5, provider: provider) # Products
            create_list(:product, 5, is_discount: true, provider: another_category_provider) # Discount for another category
            create_list(:product, 5, provider: provider, is_discount: true, discount_expire_at: 1.day.ago) # Discount expired
          end

          def log_user
            user
          end

          it "[Example] returns a list of products of a provider" do
            get_provider_discounts(provider.category)

            assert_json_match Api::V1::ProductPattern.new.list_discount(active_discounts + another_active_discounts).pattern, json
          end

          it "[Example] returns 404 if the category doest exist" do
            get_provider_discounts("fake_category")

            assert_response :not_found
          end

          def get_provider_discounts(category)
            get "/api/v1/commerce/discounts", {category: category}
          end
        end
      end
    end
  end
end
