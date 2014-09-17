json.array!(@investors) do |investor|
  json.extract! investor, :id, :name_en, :name_th
  json.url investor_url(investor, format: :json)
end
