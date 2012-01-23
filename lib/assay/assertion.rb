require_relative 'core_ext/na'
require_relative 'core_ext/exception'
require_relative 'core_ext/kernel'

# TODO: Don't care for Proc === subject conditional code, but not
# sure how else to deal with lambda subjects.

# Base class for all Assay classes. This class defines all the logic
# for assertions as exception classes as well as test assertion matchers.
#
class Assertion < Exception

  $ASSERTION_COUNTS ||= Hash.new{ |h,k| h[k] = 0 } #{:total=>0,:pass=>0,:fail=>0}

  #
  # When displaying errors, use this as a rule of thumb
  # for determining when the inspected object will be too
  # big for a single line message.
  #
  SIZE_LIMIT = 13

  class << self

    #
    # Each new subclass must call the +register+ method. This is not an option!
    # The method must be called in order to add the class to the Assertion
    # name and operator indicies, so they might be looked-up efficiently by
    # other libraries.
    #
    def register(op, name=nil)
      case op.to_s
      when /\W/
        @operator = op.to_sym
        @assertion_name = name.to_sym if name
      else
        @operator = (op.to_s + '?').to_sym
        @assertion_name = op.to_sym
      end

      operator_index[operator]   = self
      name_index[assertive_name] = self
    end

    #
    # When Assertion is inherited, a list of all Assertion subclasses is kept.
    # This can be used to assertions frameworks with dynamic implementations.
    #
    def inherited(base)
      @@by_operator = nil
      @@by_name     = nil
      subclasses << base
    end

    #
    # List of all subclasses of Assertion.
    #
    def subclasses
      @@subclasses ||= []
    end

    #
    # If operator is not given, returns a hash table of assertion classes
    # indexed by operator.
    #
    def by_operator(operator=nil)
      return operator_index.dup unless operator
      operator_index[operator.to_sym]
    end

    #
    # If operator is not given, returns a hash table of assertion classes
    # indexed by assertive name.
    #
    def by_name(name=nil)
      return name_index.dup unless name
      name_index[name.to_sym]
    end

   private

    def operator_index
      @@operator_index ||= {}
    end

    def name_index
      @@name_index ||= {}
    end

   public

    #
    # If the assertion coresponds to a regular method, particular a symbolic
    # operator (hence the name of this method) then it should be specified via
    # this interface. Otherwise, it should be given a fitting "make believe"
    # method name and specified here. If not overridden it will be assumed
    # to be the same as the `assertion_name` appended by `?`.
    #
    def operator
      @operator ||= (name.split('::').last.chomp('Assay').downcase + '?').to_sym
    end

    #
    # The assertive name is used for the construction of assertive nomenclatures
    # such as `assert_equal`.
    # 
    def assertive_name
      @assertion_name ||= (
        if operator.to_s.end_with?('?')
          operator.to_s.chomp('?').to_sym
        else
          name.split('::').last.chomp('Assay').downcase.to_sym
        end
      )
    end

    #
    # Alias for #new.
    #
    def [](*args, &blk)
      new(nil, *args, &blk)
    end

    #
    def pass?(subject, *criteria, &block)
      #raise NotImplementedError
      subject 
    end

    #
    def fail?(subject, *criteria, &block)
      ! pass?(subject, *criteria, &block)
    end

    #
    def assert!(subject, *criteria, &block)
      options = (Hash === criteria.last ? criteria.pop : {})

      #msg = options[:message]
      #bt  = options[:backtrace] || caller

      assay = new(nil, *criteria, &block)
      #assay.set_backtrace(bt)
      assay.assert!(subject, options)
    end

    # @deprecated
    alias_method :pass!, :assert!

    #
    def refute!(subject, *criteria, &block)
      options = (Hash === criteria.last ? criteria.pop : {})

      #msg = options[:message]
      #bt  = options[:backtrace] || caller

      assay = new(nil, *criteria, &block)
      #assay.set_backtrace(bt)
      assay.refute!(subject, options)
    end

    # @deprecated
    alias_method :fail!, :refute!

  end

  #
  # Setup new Assertion object.
  #
  def initialize(msg=nil, *criteria, &block)
    super(msg)

    @criteria  = criteria
    @block     = block
    @not       = false

    @assertion = true

    #options = (Hash === criteria.last ? criteria.pop : {})
    #set_backtrace(options[:backtrace]) if options[:backtrace]
    #set_negative(options[:negated])    if options[:negated]
  end

  #
  # Assertion criteria passed in via the initializer.
  #
  attr :criteria

  #
  # Block criteria passed in via the initialize method.
  #
  attr :block

  #
  # Check the assertion, return `true` if passing, `false` otherwise.
  #
  def pass?(subject)
    if Proc === subject && @block.nil?
      args = criteria
      blk  = subject
    else
      args = complete_criteria(subject)
      blk  = @block
    end

    @not ^ self.class.pass?(*args, &blk)
  end

  #
  # Test the assertion, raising the exception if failing.
  #
  def assert!(subject, options={})
    backtrace = options[:backtrace] || caller
    message   = options[:message]   || get_message(subject)

    if pass?(subject)
      increment(:pass)
    else
      increment(:fail)
      fail self, message, backtrace
    end
  end

  #
  # Alias for `#assert!`.
  #
  def pass!(subject, options={})
    assert!(subject, options={})
  end

  #
  # Check the assertion, return `true` if failing, `false` otherwise.
  #
  def fail?(subject)
    if Proc === subject && @block.nil?
      args = criteria
      blk  = subject
    else
      args = complete_criteria(subject)
      blk  = @block
    end

    @not ^ self.class.fail?(*args, &blk)
  end

  #
  # Test the refutation of the assertion.
  #
  # Test the inverse assertion, raising the exception if not failing.
  #
  def refute!(subject, options={})
    backtrace = options[:backtrace] || caller
    message   = options[:message]   || get_message(subject, true)

    if fail?(subject)
      increment(:pass)
    else
      increment(:fail)
      fail self, message, backtrace
    end
  end

  #
  # Alias for `#refute!`.
  #
  def fail!(subject, options={})
    refute!(subject, options={})
  end

  #
  #
  #
  def get_message(subject, fail=false)
    return @mesg if @mesg  # custom message
    @not ^ fail ? fail_message(subject) : pass_message(subject)
  end

  #
  #
  #
  def pass_message(subject)
    standard_message(subject)
  end

  #
  #
  #
  def fail_message(subject)
    "! " + pass_message(subject)
  end

  alias_method :==, :pass?
  alias_method :!=, :fail?

  alias_method :=~, :assert!
  alias_method :!~, :refute!

  alias_method :===, :assert!

  #
  # Create a negated form of the matcher.
  #
  # @todo Should this be @! method instead?
  #
  def ~@
    dup.negate!
  end

  #
  # Create a negated form of the matcher.
  #
  # @todo Best name for this method?
  #
  def negated
    dup.negate!
  end

  # The following methods allow Assay objects to work as RSpec matchers.

  # For RSpec matcher compatability.
  alias matches? pass?

  # For RSpec matcher compatability.
  alias does_not_match? fail?

  # For RSpec matcher compatability.
  alias failure_message_for_should pass_message

  # For RSpec matcher compatability.
  alias failure_message_for_should_not fail_message

protected

  #
  # Toggle the `@not` flag.
  #
  def negate!
    @not = !@not
    self
  end

private

  #
  # Increment global `$ASSERTION_COUNTS` variable.
  #
  def increment(which)
    $ASSERTION_COUNTS[:total] += 1
    $ASSERTION_COUNTS[which.to_sym] += 1
  end

  #
  #
  #
  def complete_criteria(subject)
    if i = @criteria.index(NA)
      @criteria[0...i] + [subject] + @criteria[i+1..-1]
    else
      [subject] + @criteria
    end
  end

  #
  # Construct a standard error message.
  #
  def standard_message(subject)
    args_inspect = [subject, *@criteria].map{ |o| o.inspect }

    op = self.class.operator

    if args_inspect.any?{ |o| o.size > SIZE_LIMIT }
      vars = ['b']
      t = args_inspect.size - 2
      t.times{ vars << vars.last.succ }

      msg = ''   
      msg << "a.#{op}(" + vars.join(',') + ")\n"
      msg << args_inspect.join("\n")
      msg
    else
      args_inspect.first + ".#{op}(" + args_inspect[1..-1].join(', ') + ")"
    end
  end

end




=begin

  ##
  #def pass_message(*criteria)
  #  return @mesg if @mesg
  #  message(*criteria)
  #end

  #
  #def fail_message(*criteria)
  #  msg = @mesg ? @mesg : pass_message(*criteria)
  #  if msg.index('should')
  #    msg.sub('should', 'should NOT')
  #  else
  #    "NOT " + msg
  #  end
  #end

  ##
  ## Set whether this failure was the inverse of it's normal meaning.
  ## For example, `!=` rather than `==`.
  ##
  #def set_negative(negative)
  #  @negative = !!negative
  #end

  #
  #def to_s
  #  #if @negative
  #  #  "NOT " + super()
  #  #else
  #    super()
  #  #end
  #end

  # Assertion Matcher is used to convert an Assertion class into an 
  # Matcher class.
  #
  # TODO: Better name for this class ?
  #
  class Matcher

    #
    def initialize(assertion, *criteria, &block)
      @assertion = assertion
      @criteria = criteria
      @block     = block
    end

    #
    def assertion
      @assertion
    end

    #
    def pass?(subject)
      if Proc === subject && @block.nil?
        @assertion.pass?(*@criteria, &subject)
      else
        @assertion.pass?(*complete_criteria(subject), &@block)
      end
    end

    #
    def fail?(subject)
      if Proc === subject && @block.nil?
        @assertion.fail?(*@criteria, &subject)
      else
        @assertion.fail?(*complete_criteria(subject), &@block)
      end
    end

    #
    def pass!(subject)
      if Proc === subject && @block.nil?
        @assertion.pass!(*@criteria, &subject)
      else
        @assertion.pass!(*complete_criteria(subject), &@block)
      end
    end

    #
    def fail!(subject)
      if Proc === subject && @block.nil?
        @assertion.fail!(*@criteria, &subject)
      else
        @assertion.fail!(*complete_criteria(subject), &@block)
      end
    end

    alias_method :==, :pass?
    alias_method :!=, :fail?

    alias_method :=~, :pass!
    alias_method :!~, :fail!

    alias_method :===, :pass!

    #
    def pass_message(subject)
      @assertion.pass_message(*complete_criteria(subject))
    end

    #
    def fail_message(subject)
      @assertion.fail_message(*complete_criteria(subject))
    end

    # For RSpec matcher compatability.
    alias matches? pass?

    # For RSpec matcher compatability.
    alias does_not_match? fail?

    # For RSpec matcher compatability.
    alias failure_message_for_should pass_message

    # For RSpec matcher compatability.
    alias failure_message_for_should_not fail_message

    ##
    ## Returns Exception instance.
    ##
    #def exception(subject, msg=nil)
    #  @assertion.new(msg || message, subject, *@criteria, &@block)     
    #  #  :negated   => options[:negated],
    #  #  :backtrace => options[:backtrace] || caller,
    #end

    ##
    #def fail(*args)
    #  super(self, *args)
    #end

    # Create a negated form of the matcher.
    #
    # @todo Should this be @! method instead?
    #
    def ~@
      Negated.new(self)
    end

    # Create a negated form of the matcher.
    #
    # @todo Best name for this method?
    #
    def negated
      Negated.new(self)
    end

  private

    def complete_criteria(subject)
      if i = @criteria.index(__)
        @criteria[0...i] + [subject] + @criteria[i+1..-1]
      else
        [subject] +  @criteria
      end
    end

    # Negated Matcher
    #
    class Negated
      def initialize(matcher)
        @matcher = matcher
      end

      def pass?(*a,&b) ; @matcher.fail?(*a,&b) ; end
      def fail?(*a,&b) ; @matcher.pass?(*a,&b) ; end
      def pass!(*a,&b) ; @matcher.fail!(*a,&b) ; end
      def fail!(*a,&b) ; @matcher.pass!(*a,&b) ; end

      alias_method :==, :pass?
      alias_method :!=, :fail?

      alias_method :=~, :pass!
      alias_method :!~, :fail!

      alias_method :===, :pass!

      def method_missing(s, *a, &b)
        @matcher.send(s, *a, &b)
      end
    end

  end

=end

