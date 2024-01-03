# frozen_string_literal: true

module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def set_current_user
    if session[:user_id].present?
      User.current = current_user
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end

