# frozen_string_literal: true

class BusinessProcessesController < ApplicationController
  before_action :set_business_process, only: [:show, :edit, :update, :destroy]

  def index
    @search = BusinessProcess.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show

  end

  def new
    @business_process = BusinessProcess.new
  end

  def create
    @business_process = BusinessProcess.new(business_process_params)
    if @business_process.save

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @business_process.update(business_process_params)

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @business_process.destroy
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @business_process.errors) }
        format.json { render(json: @business_process.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_business_process
    @business_process = BusinessProcess.find(params[:id])
  end

  def business_process_params
    params.require(:business_process).permit(:name, :description)
  end
end

