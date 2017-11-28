json.array! @providers.each do |provider|
  json.partial! 'provider', provider: provider
end
