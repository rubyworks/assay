# Load Assay's assertion classes.
dir = File.dirname(__FILE__) + '/assay/assertions'
Dir.entries(dir).each do |file|
  next if File.extname(file) != '.rb'
  require_relative 'assay/assertions/' + file
end

module Assay

  #
  # Returns Hash table of project metadata.
  #
  def self.meta
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/assay.yml'))
    )
  end

  #
  # Check metadata for missing constants.
  #
  def self.const_missing(name)
    meta[name.to_s.downcase] || super(name)
  end

  #
  # Returns a Hash table of failure classes indexed by
  # asserton operator.
  #
  # @deprecated Use `Assertion.by_operator` instead.
  #
  def self.assertions_by_operator
    Assertion.by_operator
  end

  #
  # Lookup failure class by operator.
  #
  # @deprecated Use `Assertion.by_operator(operator)` instead.
  #
  def self.lookup(operator)
    Assertion.by_operator[operator.to_sym]
  end


  # This module serves as the primary container for traditonal style assertion
  # methods, which can be mixed in to one's testing scope (e.g. World).
  #
  module Assertions
  end

  # This module holds the subject matcher methods, which can be mixin
  # to one's testing scope (e.g. World).
  #
  module Matchers
  end

  # This module holds the assertion extension mehods, which are mixed into
  # the Object class.
  #
  module Extensions
  end

  #class ::Object
  #  include Assay::Extensions
  #end

end

