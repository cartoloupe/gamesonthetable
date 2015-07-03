class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /players
  # GET /players.json
  def index
    if params.nil?
      @players = Player.all
    else
      if params.has_key? :game_id
        @players = Player.where game_id: params[:game_id]
      else
        @players = Player.all
      end
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @game = Game.find(params[:game_id])
  end

  # GET /players/1/edit
  def edit
  end


  def join
    player = Player.where({game_id: params[:game_id], user_id: current_user.id}).take
    game = Game.where(id: params[:game_id]).take

    respond_to do |format|

      if player.nil?
        player = Player.new({game_id: params[:game_id], user_id: current_user.id})

        if player.save
          format.html { redirect_to game, notice: "Successfully joined game." }
        else
          format.html { render :new }
        end

      else
        format.html { redirect_to game, notice: "Already in game." }
      end
    end
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.user_id = current_user.id

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:game_id, :game_id, :move, :comment)
    end
end
