class MovesController < ApplicationController

  def show
    logger.info "somthing"
    Move.create(user_id: session[:user_id], number_of_moves: 5)
  end
end
