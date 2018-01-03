user = @api_token.user
json.partial! 'api/v1/users/user', user: user
json.completed user.completed
json.(@api_token, :token)
