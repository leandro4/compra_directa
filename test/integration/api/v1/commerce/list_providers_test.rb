require 'test_helper'

module Api
  module V1
    module Providers
      class ListProvidersTest < Api::V1::Commerce::CommerceTest
        let(:category) { "category_2" }

        before do
          @providers = create_list(:provider, 5, category: category)

          create_list(:provider, 5)
        end

        it "[Example] returns a list of providers" do
          get_providers_list(category)

          assert_json_match Api::V1::UserPattern.new.list(@providers).pattern, json
        end

        def get_providers_list(category)
          get "/api/v1/commerce/providers", category: category
        end
      end
    end
  end
end
