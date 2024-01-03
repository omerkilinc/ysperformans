# frozen_string_literal: true

class BusinessProcess < ApplicationRecord
  validates :name, presence: true

  def self.options_for_select
    pluck(:name, :id).uniq
  end
end

