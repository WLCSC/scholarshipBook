json.array!(@sections) do |section|
  json.extract! section, :id, :title, :caption, :review_comments, :scholarship_id
  json.url section_url(section, format: :json)
end
