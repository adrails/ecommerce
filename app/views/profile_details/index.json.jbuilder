json.array!(@profile_details) do |profile_detail|
  json.extract! profile_detail, :id
  json.url profile_detail_url(profile_detail, format: :json)
end
