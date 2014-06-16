json.array!(@product_brands) do |product_brand|
  json.extract! product_brand, :id, :brand_name
  json.url product_brand_url(product_brand, format: :json)
end
