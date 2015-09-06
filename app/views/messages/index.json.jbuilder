json.array!(@messages) do |message|
  json.extract! message, :id, :user_id, :game_id, :the_text, :the_time
  json.user_name (message.user.nil? ? "" : message.user.name)
  json.url message_url(message, format: :json)
end
