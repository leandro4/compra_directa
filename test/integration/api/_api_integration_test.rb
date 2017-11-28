require 'test_helper'

Dir["#{Rails.root}/test/patterns/**/*.rb"].each { |f| require f }
Dir["#{Rails.root}/test/helpers/integration/**/*.rb"].each { |f| require f }

module Api
  class ApiIntegrationTest < ActionDispatch::IntegrationTest
    include Helpers::Integration::Api::RequestHelper
    end
end
