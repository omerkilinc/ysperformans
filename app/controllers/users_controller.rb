# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @search = User.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @user.destroy
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @user.errors) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end

