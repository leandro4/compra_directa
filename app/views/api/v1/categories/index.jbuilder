json.array! @categories.each do |k, v|
  json.id k
  json.label v
end
