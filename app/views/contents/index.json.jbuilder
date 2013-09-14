json.array!(@contents) do |content|
  json.extract! content, 
  json.url content_url(content, format: :json)
end
