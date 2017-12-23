require 'test_helper'

module Api
  module V1
    module Commerse
      module Providers
        module Products
          class CreateOrderTest < Api::ApiIntegrationTest
            let(:commerce) { create(:commerce) }
            let(:provider) { create(:provider) }
            let(:api_token) { create(:api_token, user: commerce, expire_at: 1.hour.ago) }

            let(:product1) { create(:product, provider: provider) }
            let(:product2) { create(:product, provider: provider) }
            let(:product3) { create(:product, provider: provider) }

            let(:order_params) {[{
              product_id: product1.id,
              quantity: 1
            }, {
              product_id: product2.id,
              quantity: 2
            }]}

            before do
              log_commerce; product1; product2; product3;
            end

            def log_commerce
              commerce
            end

            context "When the order is valid" do
              it "[Example] returns 200" do
                post_create_order(provider, order_params)

                assert_response :ok
              end

              it "Creates a order" do
                assert_difference("provider.orders.count", 1) do
                  post_create_order(provider, order_params)
                end
              end

              it "Creates two order items" do
                assert_difference("OrderItem.count", 2) do
                  post_create_order(provider, order_params)
                end
              end
            end

            context "When the order has invalid parameters" do
              it "[Example] reject orders with inexistant product for a provider" do
                order_params = [{
                  product_id: "some_id",
                  quantity: 1
                }]

                post_create_order(provider, order_params)
                assert_equal [t("errors.messages.not_found")], json["errors"]["product_id"]
              end

              it "reject orders with 0 or negative quantity" do
                order_params = [{
                  product_id: "some_id",
                  quantity: -1
                }]

                post_create_order(provider, order_params)
                assert_equal [t("errors.messages.greater_than")], json["errors"]["quantity"]
              end

              it "reject orders no products" do
                order_params = []

                post_create_order(provider, order_params)
                assert_equal t("errors.messages.no_products"), json["errors"]["base"]
              end
            end

            def post_create_order(provider, order)
              post "/api/v1/commerce/providers/#{provider.id}/orders", order: order
            end
          end
        end
      end
    end
  end
end
