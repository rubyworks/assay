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
  def self.assertions_by_operator
    @assertions_by_operator ||= (
      c = {}
      ObjectSpace.each_object(Class) do |fc|
        next unless fc < Assay::Assertion
        if fc.respond_to?(:assertion_operator)
          c[fc.assertion_operator.to_sym] = fc
        end
      end
      c
    )
  end

  #
  # Lookup failure class by operator.
  #
  def self.lookup(operator)
    assertions_by_operator[operator.to_sym]
  end

end

