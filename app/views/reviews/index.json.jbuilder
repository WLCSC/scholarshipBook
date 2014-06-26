json.array!(@reviews) do |review|
  json.extract! review, :id, :notes, :judge_id, :application_id, :status
  json.url review_url(review, format: :json)
end
