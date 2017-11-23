require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'

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

  class << self
    alias :context :describe
  end
end
