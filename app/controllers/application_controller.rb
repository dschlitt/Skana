class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper :nav_item

  def new_session_path(scope)
    new_user_session_path
  end

  def authenticate_user!
    redirect_to root_path if !user_signed_in?
  end
end
