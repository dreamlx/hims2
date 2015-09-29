class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :logged_in_admin

  private
    def logged_in_admin
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end
end
