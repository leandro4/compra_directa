Apipie.configure do |config|
  config.app_name                = "CompraDirecta"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"

  config.translate         = false
  config.default_locale = nil
  config.validate                = false
  config.validate_value          = false

  # set username and password for access api
  # config.authenticate = Proc.new do
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == "admin@example.com" && password == "password"
  #   end
  # end
end

