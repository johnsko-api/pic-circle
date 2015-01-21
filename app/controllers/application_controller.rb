class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize!
    if current_user.nil? || !current_user.admin?
      flash[:alert] = "You are not authorized to do this."
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:display_name]
    devise_parameter_sanitizer.for(:account_update) << [:display_name]
  end

end
