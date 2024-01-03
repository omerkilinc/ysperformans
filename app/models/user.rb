# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :performance_indicators, foreign_key: "responsible_id"

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.options_for_select
    pluck(:name, :id).uniq
  end
end

