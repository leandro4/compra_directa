require 'test_helper'

module Api
  module V1
    module Provider
      module Orders
        class AcceptOrderTest < Api::V1::Provider::ProviderTest
          it "changes the order status to accepted" do
            order = create(:order, provider: provider)

            post_accept_order(order)

            assert_response :ok

            assert_equal Order::ACCEPTED, order.reload.status
          end

          it "changes the accepted_at date" do
            order = create(:order, provider: provider)

            post_accept_order(order)

            assert_in_delta order.reload.accepted_at, Time.zone.now, 1.second
          end

          it "Sends a push notificacion to logged commerce" do
            order = create(:order, provider: provider)

            create(:api_token, user: order.commerce, expire_at: 1.hour.ago)

            stubed_request = stub_request(:post, "https://fcm.googleapis.com/fcm/send")

            post_accept_order(order)

            assert_requested(stubed_request)
          end

          it "returns not found for a order for another provider" do
            order = create(:order)

            post_accept_order(order)

            assert_response :not_found

            assert_equal Order::PENDING, order.reload.status
          end

          def post_accept_order(order)
            post "/api/v1/provider/orders/#{order.id}/accept"
          end
        end
      end
    end
  end
end
