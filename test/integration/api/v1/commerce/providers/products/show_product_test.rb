require 'test_helper'

module Api
  module V1
    module Providers
      module Products
        class ShowProductTest < Api::V1::Commerce::CommerceTest
          let(:provider) { create(:provider) }
          let(:product) { create(:product, provider: provider)}

          before do
            create_list(:question, 5, product: product)
          end

          it "[Example] shows a providers product" do
            get_provider_product(product)

            assert_json_match Api::V1::ProductPattern.new(product).with_questions.pattern, json
          end

          def get_provider_product(product)
            get "/api/v1/commerce/providers/#{product.provider.id}/products/#{product.id}"
          end
        end
      end
    end
  end
end
