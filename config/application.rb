require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CompraDirecta
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.belongs_to_required_by_default = false

    config.autoload_paths << "#{Rails.root}/app/validators"
    config.autoload_paths << "#{Rails.root}/app/exceptions"

    config.paths.add "#{config.root}/lib/validators", eager_load: true

    config.time_zone = "Buenos Aires"

    config.generators do |g|
    	g.orm :active_record, primary_key_type: :uuid
      g.view_specs false
      g.helper_specs false
      g.helper false
      g.template_engine false
      g.stylesheets false
      g.javascripts false
      g.test_framework :minitest, spec: true, fixture: false
      # g.fixture_replacement :fabrication
    end

    ENV['CATEGORIES_FILE'] = 'app/categories.yml'
  end
end
