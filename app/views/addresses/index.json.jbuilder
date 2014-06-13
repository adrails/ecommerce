json.array!(@addresses) do |address|
  json.extract! address, :id, :line_1, :line_2, :city, :state, :country, :pincode, :landmark, :profile_detail_id, :nick_name
  json.url address_url(address, format: :json)
end
