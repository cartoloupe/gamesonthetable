class Game < ActiveRecord::Base
	# as_enum :status, open: 0, forming: 1, closed: 2
	# # as_enum is a feature of the simple_enum gem (I'm lazy)

	def end_time_ms
		(end_time.to_f * 1000).to_i
	end

	# The following code broadcasts to a channel using the same mechanism as in move.rb.
	# See https://github.com/websocket-rails/websocket-rails/wiki/Working-with-Channels
  after_create :publish_create_game

  def publish_create_game
    WebsocketRails[:games].trigger 'reload', self
  end

	# The following code updates the time left in the game and sends it to
	# the client


end
