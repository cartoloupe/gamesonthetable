json.array!(@players) do |player|
  json.extract! player, :id, :name, :comment
  json.user_name (player.user.nil? ? "" : player.user.name)
  json.url player_url(player, format: :json)
end
