class WebsocketMovesController < WebsocketRails::BaseController
  #def create
  #  raise message.inspect
  #end

  def destroy
    Move.first.destroy
    render :nothing
  end

  def user_logged_in
    # The `message` method contains the data received
    WebsocketRails[:user].trigger 'logged_in', message[:user]
  end

end
