# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.t_attr(*args)
    human_attribute_name(*args)
  end

  class << self
    def ransackable_attributes(auth_object = nil)
      column_names + _ransackers.keys
    end

    # `ransackable_associations` by default returns the names
    # of all associations as an array of strings.
    # For overriding with a whitelist array of strings.
    #
    def ransackable_associations(auth_object = nil)
      reflect_on_all_associations.map { |a| a.name.to_s }
    end

    # `ransortable_attributes` by default returns the names
    # of all attributes available for sorting as an array of strings.
    # For overriding with a whitelist array of strings.
    #
    def ransortable_attributes(auth_object = nil)
      ransackable_attributes(auth_object)
    end

    # `ransackable_scopes` by default returns an empty array
    # i.e. no class methods/scopes are authorized.
    # For overriding with a whitelist array of *symbols*.
    #
    def ransackable_scopes(auth_object = nil)
      []
    end

    def t_col(*args)
      human_attribute_name(*args)
    end
  end
end
