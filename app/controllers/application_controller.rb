class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :condition

  def condition
    if params[:type].present?
      session[:condition] = params[:type]
    else
      unless session[:condition].present?
        session[:condition] = "NEW"
      end
    end
  end

end
