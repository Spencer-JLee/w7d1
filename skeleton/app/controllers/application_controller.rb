class ApplicationController < ActionController::Base

  helper_method :current_user, :login?

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def login?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless login?
  end

  def require_logged_out
    redirect_to users_url if login? 
  end

end
