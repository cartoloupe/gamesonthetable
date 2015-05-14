class MovesController < ApplicationController

  # def show
  #   logger.info "somthing"
  #   Move.create(user_id: session[:user_id], number_of_moves: 5)
  # end

  def index
    @moves = Move.all
    respond_to do |format|
      format.json do
        render json: @moves
      end
      format.html {}
    end

  end

  def create
    # raise params.inspect
    # logger.info params.inspect
    user = User.find(session[:game_user])
    @some_move = Move.where(user: user).first
    @some_move.update(number_of_moves: move_params[:number_of_moves])
    # @move = Move.create(move_params)
    # render json: @move
    render json: @some_move
  end

  private
  def move_params
    params.require(:move).permit(:number_of_moves)
  end
end
