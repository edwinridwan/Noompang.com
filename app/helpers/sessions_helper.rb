module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    # update user information
    User.update_all ['current_sign_in_at = ?', Time.now], ['id = ?', current_user.id]
    User.update_all ['sign_in_count = ?', current_user.sign_in_count + 1], ['id = ?', current_user.id]
    User.update_all ['current_sign_in_ip = ?', request.remote_ip], ['id = ?', current_user.id]
    current_user = user
  end

  # Returns true if this user is currently signed in
  def signed_in?
    !current_user.nil?
  end

  # Defines a method current_user= expressly designed to handle assignment to current_user
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # AUTHORIZATION
  def current_user?(user)
    user == current_user
  end

  def sign_out
    # update user information
    User.update_all ['last_sign_in_at = ?', current_user.current_sign_in_at], ['id = ?', current_user.id]
    User.update_all ['current_sign_in_at = ?', nil], ['id = ?', current_user.id]
    User.update_all ['last_sign_in_ip = ?', current_user.current_sign_in_ip], ['id = ?', current_user.id]
    User.update_all ['current_sign_in_ip = ?', nil], ['id = ?', current_user.id]
    current_user = nil # reset current_user
    cookies.delete(:remember_token)
  end

  # FRIENDLY FORWARDING
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end
