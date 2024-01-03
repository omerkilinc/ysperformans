# frozen_string_literal: true

class PerformanceMeasurementsController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]
  before_action :set_indicator

  def index
    @search = PerformanceMeasurement.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show

  end

  def new
    @performance_measurement = PerformanceMeasurement.new
  end

  def create
    @performance_measurement = PerformanceMeasurement.new(performance_params)
    if @performance_measurement.save
      redirect_to(performance_indicator_path(@performance_indicator))
    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @performance_measurement.update(performance_params)
      redirect_to(performance_indicator_path(@performance_indicator))
    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @performance_measurement.destroy
      redirect_to(performance_indicator_path(@performance_indicator))
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @performance_measurement.errors) }
        format.json { render(json: @performance_measurement.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_performance
    @performance_measurement = PerformanceMeasurement.find(params[:id])
  end

  def set_indicator
    @performance_indicator = PerformanceIndicator.find(params[:performance_indicator_id])
  end

  def performance_params
    params.require(:performance_measurement).permit(:user_id, :performance_indicator_id, :start_date, :end_date,
      :target_date, :measured_value, :measurement_date)
  end
end

