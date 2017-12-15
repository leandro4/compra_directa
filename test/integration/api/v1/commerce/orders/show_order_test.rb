require 'test_helper'

module Api
  module V1
    module Commerce
      module Orders
        class ShowOrderTest < Api::ApiIntegrationTest
          let(:commerce) { create(:commerce) }
          let(:api_token) { create(:api_token, user: commerce, expire_at: 1.hour.ago) }

          before do
            log_user;
          end

          def log_user
            commerce
          end

          it "[Example] returns logger provider's order" do
            order = create(:order, commerce: commerce)

            get_order(order)

            assert_json_match Api::V1::OrderPattern.new(order).for_commerce.pattern, json
          end

          it "returns 404 for a not logged provider's order" do
            order = create(:order)

            get_order(order)

            assert_response :not_found
          end

          def get_order(order)
            get "/api/v1/commerce/orders/#{order.id}"
          end
        end
      end
    end
  end
end
