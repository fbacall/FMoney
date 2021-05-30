class StaticController < ApplicationController
  skip_before_action :require_user

  def home
    if current_user
      redirect_to transactions_path
    end
  end

end
