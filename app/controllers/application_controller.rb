class ApplicationController < ActionController::Base
  helper_method :is_admin?

  def is_admin?
    user_signed_in? && current_user.admin?
  end

  def authorize_user
    if !is_admin?
      redirect_to root_path, alert: "You are not authorized to perform that action."
    end
  end
end
