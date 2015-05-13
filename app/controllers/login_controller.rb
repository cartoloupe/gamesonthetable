class LoginController < ApplicationController
  def create
    user = User.find params[:id]

    redirect_to controller: 'sessions', user: user.name, password: user.password
  end

  private
  def login_params
    params.require(:login).permit(:id)
  end
end
