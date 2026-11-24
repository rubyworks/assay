# Assay (https://github.com/rubyworks/assay)
# Copyright (c) 2010 Rubyworks. License (spdx) BSD-2-Clause.

require_relative 'assay/version'

# Load Assay's assertion classes.
require_relative 'assay/assertion'
Dir[File.join(__dir__, 'assay', '*_assay.rb')].sort.each do |file|
  require_relative 'assay/' + File.basename(file, '.rb')
end

module Assay

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
  # Two inspected values with the differences between them colored, for
  # failure messages when color is on. Color can be turned on from
  # outside Assay (the ANSI gem sets `$ansi` when it loads), so the diff
  # library is loaded here, where it is used.
  #
  # @return [Array<String>] the two values, colored
  #
  def self.color_diff(a, b)
    require 'ansi/diff'
    diff = ::ANSI::Diff.new(a, b)
    return diff.diff1, diff.diff2
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

