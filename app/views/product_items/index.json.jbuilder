json.array!(@product_items) do |product_item|
  json.extract! product_item, :id, :title, :available_quantity, :description, :price, :user_id, :is_active
  json.url product_item_url(product_item, format: :json)
end
