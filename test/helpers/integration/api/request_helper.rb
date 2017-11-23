module Helpers
  module Integration
    module Api
      module RequestHelper
        def json
          JSON.parse(response.body)
        end

        [:get, :post, :put, :delete].each do |method|
          define_method(method) do |path, parameters = {}, headers_or_env = {}|
            headers_or_env.merge!({ 'Accept' => Mime[:json], 'Content-Type' => Mime[:json].to_s })
            begin
              headers_or_env.merge!(authorization: "Token #{api_token.token}")
            rescue NameError; end
            parameters = parameters.to_json unless method == :get
            super(path, params: parameters, headers: headers_or_env)
          end
        end
      end
    end
  end
end
