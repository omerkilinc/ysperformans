# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :performance_departments, dependent: :destroy
  has_many :performance_indicators, through: :performance_departments
  validates :name, presence: true

  def self.options_for_select
    pluck(:name, :id).uniq
  end
end

