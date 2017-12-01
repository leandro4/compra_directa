json.partial! 'api/v1/providers/provider', provider: @api_token.user
json.(@api_token, :token)
