require 'test_helper'

module Api
  module V1
    module Provider
      module Orders
        class RejectOrderTest < Api::V1::Provider::ProviderTest

          it "changes the order status to accepted" do
            order = create(:order, provider: provider)

            post_reject_order(order)

            assert_response :ok

            assert_equal Order::REJECTED, order.reload.status
          end

          it "changes the order status to accepted" do
            order = create(:order)

            post_reject_order(order)

            assert_response :not_found

            assert_equal Order::PENDING, order.reload.status
          end

          it "Sends a push notificacion to logged commerce" do
            order = create(:order, provider: provider)

            create(:api_token, user: order.commerce, expire_at: 1.hour.ago)

            stubed_request = stub_request(:post, "https://fcm.googleapis.com/fcm/send")

            post_reject_order(order)

            assert_requested(stubed_request)
          end

          def post_reject_order(order)
            post "/api/v1/provider/orders/#{order.id}/reject"
          end
        end
      end
    end
  end
end
