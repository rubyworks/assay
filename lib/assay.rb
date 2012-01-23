# Load Assay's assertion classes.
require_relative 'assay/assertion'
dir = File.dirname(__FILE__) + '/assay'
Dir.entries(dir).each do |file|
  next if File.extname(file) != '.rb'
  require_relative 'assay/' + file
end

module Assay

  #
  # Returns Hash table of project metadata.
  #
  def self.metadata
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/assay.yml'))
    )
  end

  #
  # Check metadata for missing constants.
  #
  def self.const_missing(name)
    metadata[name.to_s.downcase] || super(name)
  end

  #
  # Returns a list of Assertion subclasses.
  #
  def self.assertions
    Assertion.subclasses
  end

  #
  # Set ANSI color mode. Default is false, so set to `true` to get ANSI color
  # in some error messages.
  #
  # @example
  #   Assay.color = true
  #
  def self.color=(boolean)
    if boolean
      require 'ansi/diff'
      $ansi = true
    else
      $ansi = false
    end 
  end

  #
  # Lookup assay class by operator or name.
  #
  def self.lookup(symbol)
    lookup_by_operator(symbol) || lookup_by_name(symbol)
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by operator.
  #
  def self.lookup_by_operator(operator=nil)
    Assertion.by_operator(operator)
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by assertive name.
  #
  def self.lookup_by_name(name=nil)
    Assertion.by_name(name)
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

