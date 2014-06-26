json.array!(@scholarships) do |scholarship|
  json.extract! scholarship, :id, :title, :caption, :global, :active
  json.url scholarship_url(scholarship, format: :json)
end
