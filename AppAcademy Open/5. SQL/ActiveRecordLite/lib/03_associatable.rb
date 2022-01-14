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
    # ...
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end
