# frozen_string_literal: true

class PerformanceIndicator < ApplicationRecord
  enum indicator_status: { happened: 0, nothappened: 1, notmeasured: 2 }
  enum measured_method: { manuel: 0 }
  enum measurement_criteria: { target_date: 0, value: 1 }
  enum value_parameter: { equal: 0, greater: 1, less: 2, greater_than: 3, less_than: 4 }

  belongs_to :standart
  belongs_to :business_process
  belongs_to :responsible, class_name: "User"
  has_many :performance_departments, dependent: :destroy
  has_many :departments, through: :performance_departments

  has_many :performance_measurements

  def self.measured_method_options
    measured_methods.map do |p, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.measured_methods.#{p}"), p]
    end
  end

  def self.measurement_criteria_options
    measurement_criteria.map do |p, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.measurement_criterias.#{p}"), p]
    end
  end

  def self.value_parameter_options
    value_parameters.map do |p, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.value_parameters.#{p}"), p]
    end
  end
end

