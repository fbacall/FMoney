class ApplicationController < ActionController::Base
  before_action :require_user
  helper_method :current_user

  def current_user
    @current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
  end

  private

  def require_user
    unless current_user
      flash[:alert] = 'Requires login.'
      render 'static/home'
    end
  end
end
