# frozen_string_literal: true

class PerformanceDepartment < ApplicationRecord
  belongs_to :department
  belongs_to :performance_indicator
end

