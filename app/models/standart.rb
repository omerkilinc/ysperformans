# frozen_string_literal: true

class Standart < ApplicationRecord
  has_many :performance_indicators

  validates :name, presence: true

  def self.options_for_select
    all.uniq.map { |m| [I18n.t("g.#{m.name}"), m.id] }
  end

end

