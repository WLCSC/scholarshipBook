json.array!(@messages) do |message|
  json.extract! message, :id, :text, :status
  json.url message_url(message, format: :json)
end
