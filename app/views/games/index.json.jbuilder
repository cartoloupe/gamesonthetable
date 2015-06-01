json.array!(@games) do |game|
  json.extract! game, :id, :name, :secs_left, :num_users, :open
  json.url game_url(game, format: :json)
end
