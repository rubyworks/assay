module Assay
  #VERSION="1.0.0"

  # Returns a Hash table of failure classes indexed by
  # asserton operator.
  def self.failure_classes_by_operator
    @_failure_classes_by_operator ||= (
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

  # Lookup failure class by operator.
  def self.lookup(operator)
    failure_classes_by_operator[operator.to_sym]
  end

  # Returns Hash table of project metadata.
  def self.meta
    @spec ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/assay.yml'))
    )
  end

  # Check metadata for missing constants.
  def self.const_missing(name)
    meta[name.to_s.downcase] || super(name)
  end
end

# Load Assay's failure classes.
dir  = File.dirname(__FILE__)
glob = File.join(dir, 'assay', 'assertions', '*.rb')
Dir[glob].each do |rb|
  require 'assay/assertions/' + File.basename(rb)
end

