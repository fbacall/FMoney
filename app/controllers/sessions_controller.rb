class SessionsController < ApplicationController
  skip_before_action :require_user
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @user = User.from_omniauth(auth_hash)
    @current_user = @user
    session[:current_user_id] = @user.id
    flash[:notice] = 'Logged in!'
    redirect_to :root
  end

  def destroy
    flash[:notice] = 'Logged out!'
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to :root
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
