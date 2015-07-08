json.array!(@games) do |game|
  json.extract! game, :id, :name, :end_time, :end_time_ms, :num_users, :status
  json.curr_num_users game.players.count
  json.in_game game.players.exists?(user_id: current_user.id)
  json.url game_url(game, format: :json)
end
