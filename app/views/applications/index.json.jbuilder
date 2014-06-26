json.array!(@applications) do |application|
  json.extract! application, :id, :applicant_id, :scholarship_id, :status
  json.url application_url(application, format: :json)
end
