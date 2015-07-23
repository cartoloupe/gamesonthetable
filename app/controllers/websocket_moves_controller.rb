class WebsocketMovesController < WebsocketRails::BaseController
  def destroy
    Move.first.destroy
    render :nothing
  end

  def user_logged_in
    Rails.logger.debug 'user_logged_in'
    # The `message` method contains the data received
    WebsocketRails[:user].trigger 'logged_in', message[:user]
  end

  def broadcast_move
    Rails.logger.debug 'broadcast_move'
    # The `message` method contains the data received
    WebsocketRails[:moves].trigger 'reddot', message
  end

  def broadcast_move_dragged
    Rails.logger.debug 'broadcast_dragged'
    Rails.logger.debug message
    WebsocketRails[:moves].trigger 'dragged', message
  end
end
