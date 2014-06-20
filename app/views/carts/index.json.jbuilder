json.array!(@carts) do |cart|
  json.extract! cart, :id, :user_id, :product_item_ids
  json.url cart_url(cart, format: :json)
end
