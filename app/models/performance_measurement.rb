# frozen_string_literal: true

class PerformanceMeasurement < ApplicationRecord
  belongs_to :performance_indicator
  belongs_to :user

  after_commit :update_indicator, on: [:create, :update, :destroy]

  def update_indicator
    total = self.performance_indicator.performance_measurements.sum(:measured_value)
    self.performance_indicator.update_column(:last_measured_value, total)

    indicator_status = "nothappened"
    case self.performance_indicator.value_parameter
    when "equal"
      indicator_status = self.performance_indicator.last_measured_value.to_i == self.performance_indicator.targeted_value ? "happened" : "nothappened"
    when "greater"
      indicator_status = self.performance_indicator.last_measured_value.to_i > self.performance_indicator.targeted_value ? "happened" : "nothappened"
    when "less"
      indicator_status = self.performance_indicator.last_measured_value.to_i < self.performance_indicator.targeted_value ? "happened" : "nothappened"
    when "greater_than"
      indicator_status = self.performance_indicator.last_measured_value.to_i >= self.performance_indicator.targeted_value ? "happened" : "nothappened"
    when "less_than"
      indicator_status = self.performance_indicator.last_measured_value.to_i <= self.performance_indicator.targeted_value ? "happened" : "nothappened"
    end

    self.performance_indicator.update_column(:indicator_status, indicator_status)

  end

end

