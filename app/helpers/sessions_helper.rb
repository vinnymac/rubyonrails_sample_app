module SessionsHelper

  def sign_in(user)
    # First, Create a New Token
    remember_token = User.new_remember_token
    # Second, Place the Unencrypted token in the cookies
    cookies.permanent[:remember_token] = remember_token
    # Third, Save the Encrypted Token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # Fourth, Set the current user equal to the given user
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
