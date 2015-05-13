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
    else
      @a = 'not logged in'
      render 'new'
    end
  end

end


