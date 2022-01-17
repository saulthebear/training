require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    default_foreign_key = "#{name}_id".downcase.to_sym
    @foreign_key = options.key?(:foreign_key) ? options[:foreign_key] : default_foreign_key
    @primary_key = options.key?(:primary_key) ? options[:primary_key] : :id
    default_class_name = name.to_s.singularize.camelcase
    @class_name = options.key?(:class_name) ? options[:class_name] : default_class_name
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    default_foreign_key = "#{self_class_name}_id".downcase.to_sym
    @foreign_key = options.key?(:foreign_key) ? options[:foreign_key] : default_foreign_key
    @primary_key = options.key?(:primary_key) ? options[:primary_key] : :id
    default_class_name = name.to_s.singularize.camelcase
    @class_name = options.key?(:class_name) ? options[:class_name] : default_class_name
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options
    define_method(name) do
      fk_value = send(options.foreign_key)
      options.model_class.where({ options.primary_key => fk_value }).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      pk_value = send(options.primary_key)
      options.model_class.where({ options.foreign_key => pk_value })
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
