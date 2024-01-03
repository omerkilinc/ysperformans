# frozen_string_literal: true

class PerformanceIndicatorsController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  def index
    @search = PerformanceIndicator.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show
    @search = @performance_indicator.performance_measurements.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def new
    @performance_indicator = PerformanceIndicator.new
  end

  def create
    @performance_indicator = PerformanceIndicator.new(performance_params)
    if @performance_indicator.save

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @performance_indicator.update(performance_params)

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @performance_indicator.destroy
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @performance_indicator.errors) }
        format.json { render(json: @performance_indicator.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_performance
    @performance_indicator = PerformanceIndicator.find(params[:id])
  end

  def performance_params
    params.require(:performance_indicator).permit(:status, :measured_method, :measurement_criteria, :value_parameter,
      :business_process_id, :responsible_id, :standart_id, :name, :description, :targeted_date, :targeted_value,
      :last_measured_value, department_ids: [])
  end
end

