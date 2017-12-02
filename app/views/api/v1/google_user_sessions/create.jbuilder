user = @api_token.user
json.partial! 'api/v1/providers/provider', provider: user
json.user_type user.type.to_s.tableize
json.completed user.completed
json.(@api_token, :token)
