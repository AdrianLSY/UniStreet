class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  private

  def logged_in?
    redirect_to login_path if current_user.nil?
  end

  def not_found
    raise ActionController::RoutingError.new('404 Not Found')
  end

  def student?
    not_found unless current_user.student?
  end

  def uni_admin?
    not_found unless current_user.university_admin?
  end


  def sas_admin?
    not_found unless current_user.sas_admin?
  end

end