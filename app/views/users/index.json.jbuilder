json.array!(@users) do |user|
  json.extract! user, :id, :username, :administrator, :name, :email_address, :password_hash, :password_salt, :internal
  json.url user_url(user, format: :json)
end
