json.array! @providers.each do |provider|
  json.partial! 'api/v1/users/user', user: provider
end
