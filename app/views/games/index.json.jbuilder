json.array!(@games) do |game|
  json.extract! game, :id, :name, :end_time, :end_time_ms, :num_users, :status
  json.url game_url(game, format: :json)
end
