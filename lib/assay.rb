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
  # Returns a Hash table of failure classes indexed by
  # asserton operator.
  #
  # @deprecated Use `Assertion.by_operator` instead.
  #
  def self.assertions_by_operator
    Assertion.by_operator
  end

  #
  # Lookup assay class by operator or name.
  #
  def self.lookup(symbol)
    lookup_by_operator[symbol.to_sym] || lookup_by_name[symbol.to_sym]
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by operator.
  #
  def self.lookup_by_operator(operator=nil)
    operator = operator.to_sym if operator

    @by_operator ||= (
      hash = {}
      Assertion.subclasses.each do |c|
        if op = c.operator
          hash[op.to_sym] = c
        end
      end
      hash
    )

    operator ? @by_operator[operator.to_sym] : @by_operator
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by assertive name.
  #
  def self.lookup_by_name(name=nil)
    name = name.to_sym if name

    @by_name ||= (
      hash = {}
      Assertion.subclasses.each do |c|
        if op = c.assertive_name
          hash[op.to_sym] = c
        end
      end
      hash
    )

    name ? @by_name[name.to_sym] : @by_name
  end

  #
  # Set ANSI color mode. Default is true, so if you need to force ANSI color
  # code to omitted from output message you can set `Assay.color = false`.
  #
  def self.color=(boolean)
    $ansi = boolean ? true : false
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

