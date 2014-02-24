class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_signin
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def require_signin
    unless current_user
      redirect_to signin_path
    end
  end

  def require_super_user
    raise "Signin is required" unless current_user
    unless current_user.super_user?
      render file: "public/404", status: 404, layout: false and return
    end
  end
end
