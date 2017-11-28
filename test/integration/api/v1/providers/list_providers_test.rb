require 'test_helper'

module Api
  module V1
    module Providers
      class ListProvidersTest < Api::V1::Providers::ProviderTest
        before do
          @users = create_list(:provider, 5)
        end


        it "[Example] returns a list of providers" do
          get_providers_list

          assert_json_match Api::V1::UserPattern.new(@users.last).pattern, json.last
        end

        def get_providers_list
          get "/api/v1/providers"
        end
      end
    end
  end
end
