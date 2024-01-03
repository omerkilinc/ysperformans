# frozen_string_literal: true

class StandartsController < ApplicationController
  before_action :set_standart, only: [:show, :edit, :update, :destroy]

  def index
    @search = Standart.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show

  end

  def new
    @standart = Standart.new
  end

  def create
    @standart = Standart.new(standart_params)
    if @standart.save

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @standart.update(standart_params)

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @standart.destroy
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @standart.errors) }
        format.json { render(json: @standart.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_standart
    @standart = Standart.find(params[:id])
  end

  def standart_params
    params.require(:standart).permit(:name, :description)
  end
end

