require 'test_helper'

module Api
  module V1
    module Commerce
      module Orders
        class ListOrdersTest < Api::ApiIntegrationTest
          let(:commerce) { create(:commerce) }
          let(:api_token) { create(:api_token, user: commerce, expire_at: 1.hour.ago) }

          let(:orders) { create_list(:order, 5, commerce: commerce)}
          let(:another_orders) { create_list(:order, 5)}

          before do
            log_commerce; orders
          end

          def log_commerce
            commerce
          end

          it "[Example] returns a list of orders" do
            get_orders_list

            assert_json_match Api::V1::OrderPattern.new.list_for_commerce(orders).pattern, json
          end

          def get_orders_list
            get "/api/v1/commerce/orders"
          end
        end
      end
    end
  end
end
