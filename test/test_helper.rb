require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require 'webmock/minitest'
require 'json_expressions/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  include AbstractController::Translation
  include FactoryBot::Syntax::Methods

  Apipie.record('examples') if ENV['DOC_API']
  Apipie.record('params') if ENV['DOC_EXAMPLES']

  DatabaseCleaner.strategy = :truncation

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end

  Fog.mock!

  service = Fog::Storage.new({
    provider:                 'AWS',
    aws_access_key_id:     ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET'],
    region: ENV['S3_REGION']
  })

  service.directories.create(key: ENV['S3_BUCKET'])

  class << self
    alias :context :describe
  end
end
