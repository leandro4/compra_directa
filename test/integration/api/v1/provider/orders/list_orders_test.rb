require 'test_helper'

module Api
  module V1
    module Provider
      module Orders
        class ListOrdersTest < Api::V1::Provider::ProviderTest
          let(:pending_orders) { create_list(:order, 5, provider: provider) }
          let(:accepted_orders) { create_list(:order, 5, provider: provider, status: Order::ACCEPTED) }
          let(:rejected_orders) { create_list(:order, 5, provider: provider, status: Order::REJECTED) }

          before do
            pending_orders; accepted_orders; rejected_orders
          end

          it "[Example] returns a list of orders" do
              get_orders

              assert_json_match Api::V1::OrderPattern.new.list_for_provider(pending_orders + accepted_orders + rejected_orders).pattern, json
          end

          it "[Example] returns a list of orders with filter" do
            Order::STATUSES.each do |status|
              get_orders(status)

              assert_json_match Api::V1::OrderPattern.new.list_for_provider(send("#{status}_orders")).pattern, json
            end
          end

          # it "returns 404 for a not logged provider's order" do
          #   order = create(:order)

          #   get_order(order)

          #   assert_response :not_found
          # end

          def get_orders(status = nil)
            get "/api/v1/provider/orders?status=#{status}"
          end
        end
      end
    end
  end
end
