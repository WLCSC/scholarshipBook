json.array!(@fields) do |field|
  json.extract! field, :id, :section_id, :title, :caption, :type, :config, :completed_by
  json.url field_url(field, format: :json)
end
