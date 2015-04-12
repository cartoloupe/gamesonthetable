class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def create
    user = User.find_by_name params[:session][:name]
    if user && user.password == params[:session][:password]
      log_in user
      @a = 'logged in'
    else
      @a = 'not logged in'
    end
    logger.debug "B" * 1000
    logger.debug session
    render 'new'
  end
end
