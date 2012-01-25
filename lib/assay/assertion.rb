require 'brass'

require_relative 'core_ext/na'
require_relative 'core_ext/kernel'

require_relative 'assertor'
require_relative 'assertable'

# TODO: Don't care for Proc === subject conditional code, but not
# sure how else to deal with lambda subjects.

# Base class for all Assay classes. This class defines all the logic
# for assertions as exception classes as well as test assertion matchers.
#
class Assertion < Exception

  extend Assay::Assertable

  #
  # When displaying errors, use this as a rule of thumb
  # for determining when the inspected object will be too
  # big for a single line message.
  #
  SIZE_LIMIT = 13

  #
  # Each new subclass must call the +register+ method. This is not an option!
  # The method must be called in order to add the class to the Assertion
  # name and operator indicies, so they might be looked-up efficiently by
  # other libraries.
  #
  def self.register(op, name=nil)
    case op.to_s
    when /\W/
      @operator = op.to_sym
      @assertive_name = name.to_sym if name
    else
      @operator = (op.to_s + '?').to_sym
      @assertive_name = op.to_sym
    end

    operator_index[operator]   = self
    name_index[assertive_name] = self
  end

  #
  # When Assertion is inherited, a list of all Assertion subclasses is kept.
  # This can be used to assertions frameworks with dynamic implementations.
  #
  def self.inherited(base)
    @@by_operator = nil
    @@by_name     = nil
    subclasses << base
  end

  #
  # List of all subclasses of Assertion.
  #
  def self.subclasses
    @@subclasses ||= []
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by operator.
  #
  def self.by_operator(operator=nil)
    return operator_index.dup unless operator
    operator_index[operator.to_sym]
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by assertive name.
  #
  def self.by_name(name=nil)
    return name_index.dup unless name
    name_index[name.to_sym]
  end

  private

    def self.operator_index
      @@operator_index ||= {}
    end

    def self.name_index
      @@name_index ||= {}
    end

  #
  # Setup new Assertion object.
  #
  def initialize(msg=nil) #, *criteria, &block)
    super(msg)

    #@criteria  = criteria
    #@block     = block
    #@not       = false

    @assertion = true

    #options = (Hash === criteria.last ? criteria.pop : {})
    #set_backtrace(options[:backtrace]) if options[:backtrace]
    #set_negative(options[:negated])    if options[:negated]
  end

end


=begin

  #
  #def to_s
  #  #if @negative
  #  #  "NOT " + super()
  #  #else
  #    super()
  #  #end
  #end

=end

