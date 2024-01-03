# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :user_authenticated?
  before_action :set_current_user
  include Pagy::Backend

  def search_params
    params[:q]
  end

  protected

  def user_authenticated?
    unless logged_in?
      if request.xhr?
        flash.now[:error] = "Please Login First"
        render(js: "window.location = '/'")
      else
        redirect_to(login_path, alert: "Once Giris Yapiniz")
      end
    end
  end
end
