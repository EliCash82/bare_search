json.array!(@comics) do |comic|
  json.extract! comic, :id, :name, :issue, :summary
  json.url comic_url(comic, format: :json)
end
