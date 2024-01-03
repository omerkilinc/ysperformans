# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  layout "login"
  before_action :user_authenticated?, only: :destroy
  before_action :redirect_authenticates, only: [:new, :create]

  def new

  end

  def create
    username = params[:username]
    password = params[:password]

    if username.empty?
      redirect_to(:login, alert: "Kullanici Adi Bos Olamaz")
      return
    end

    user = User.find_by(username: username)

    if user.present? && user&.authenticate(password)
      log_in(user)
      logger.info("#{user.username} giris yapti")
      redirect_to(:root, notice: "Giris Basarili")
      return
    else
      logger.warn("#{username} parola yanlis")
      redirect_to(:login, alert: "Kullanici Adi yada Parola Hatali")
      return
    end

  end

  def destroy
    logger.info("#{current_user.username} is logged out.")
    log_out
    redirect_to(:login, notice: "Oturum Kapatildi")
  end

  private

  def redirect_authenticates
    if logged_in?
      if session[:forwarding_url].present? && !session[:forwarding_url] == logout_path
        redirect_to(session[:forwarding_url])
      else
        redirect_to(root_url)
      end
    end
  end

end
