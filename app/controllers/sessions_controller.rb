class SessionsController < ApplicationController
  include SessionsHelper

  def show
    @test = "show triggered"
    #send_message :create
  end

  def client_connected
  end

  def create
    user = User.find_by_name params[:session][:name]
    if user && user.password == params[:session][:password]
      log_in user
      @a = 'logged in'
      redirect_to moves_path
      session[:game_user] = user.id
    else
      @a = 'not logged in'
      render 'new'
    end
    # logger.debug "B" * 1000
    # logger.debug session
    # render 'new'
    logger.info session[:game_user]
  end

  def logout
    session.delete(:game_user)
    redirect_to root_path
  end

end


