require 'test_helper'

module Api
  module V1
    module Categories
      class ListCategoriesTest < Api::ApiIntegrationTest
        let(:categories) { Category.all }

        it "[Example] returns a list of all categories" do
          get_categories

          # assert_equal categories, json
        end

        def get_categories
          get "/api/v1/categories"
        end
      end
    end
  end
end
