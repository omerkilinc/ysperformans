# frozen_string_literal: true

class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def index
    @search = Department.all.ransack(search_params)
    @search.sorts = "id" if @search.sorts.empty?
    @pagy, @records = pagy(@search.result)
  end

  def show

  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def edit

  end

  def update
    if @department.update(department_params)

    else
      render(:form_update, status: :unprocessable_entity)
    end
  end

  def destroy
    if @department.destroy
    else
      respond_to do |format|
        format.html { render(:edit, status: :unprocessable_entity, errors: @department.errors) }
        format.json { render(json: @department.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :description)
  end
end

