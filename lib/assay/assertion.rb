require 'ansi/diff'  # ANSI color output support

require_relative 'core_ext/na'
require_relative 'core_ext/exception'
require_relative 'core_ext/kernel'

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
      new(*args, &blk)
    end

    #
    def pass?(target, *criteria, &block)
      raise NotImplementedError
    end

    #
    def fail?(target, *criteria, &block)
      ! pass?(target, *criteria, &block)
    end

    #
    def assert!(target, *criteria, &block)
      options = (Hash === criteria.last ? criteria.pop : {})

      msg = options[:message]
      bt  = options[:backtrace] || caller

      #if ! pass?(target, *criteria, &block)
        assay = new(msg, *criteria, &block)
        assay.set_backtrace(bt)
        assay.assert!(target)
      #end
    end

    # @deprecated
    alias_method :pass!, :assert!

    #
    def refute!(target, *criteria, &block)
      #if ! fail?(target, *criteria, &block)
        new(nil, *criteria, &block).fail!(target)
      #end
    end

    # @deprecated
    alias_method :fail!, :refute!

  end

  #
  #
  #
  def initialize(msg=nil, *criteria, &block)
    super(msg)

    @criteria = criteria
    @block    = block
    @not      = false

    #options = (Hash === criteria.last ? criteria.pop : {})
    #set_backtrace(options[:backtrace]) if options[:backtrace]
    #set_negative(options[:negated])    if options[:negated]
  end

  # criteria
  attr :criteria

  # block
  attr :block

  #
  # Check the assertion, return `true` if passing, `false` otherwise.
  #
  def pass?(target)
    if Proc === target && @block.nil?
      args = criteria
      blk  = target
    else
      args = complete_criteria(target)
      blk  = @block
    end
    @not ^ self.class.pass?(*args, &blk)
  end

  #
  # Test the assertion, raising the exception if failing.
  #
  def pass!(target, options={})
    backtrace = options[:backtrace] || caller
    message   = options[:message]   || get_message(target)

    if pass?(target)
      increment(:pass)
    else
      increment(:fail)
      fail self, message, backtrace
    end
  end

  #
  # Alias for `#pass!`.
  #
  def assert(target, options={})
    pass!(target, options={})
  end

  #
  # Check the assertion, return `true` if failing, `false` otherwise.
  #
  def fail?(target)
    if Proc === target && @block.nil?
      args = criteria
      blk  = target
    else
      args = complete_criteria(target)
      blk  = @block
    end

    @not ^ self.class.fail?(*args, &blk)
  end

  #
  # Test the refutation of the assertion.
  #
  # Test the inverse assertion, raising the exception if not failing.
  #
  def fail!(target, options={})
    backtrace = options[:backtrace] || caller
    message   = options[:message]   || get_message(target, true)

    if fail?(target)
      increment(:pass)
    else
      increment(:fail)
      fail self, message, backtrace
    end
  end

  #
  # Alias for `#fail!`.
  #
  def refute(target, options={})
    fail!(target, options={})
  end

  #
  #
  #
  def get_message(target, fail=false)
    return @mesg if @mesg  # custom message
    @not ^ fail ? fail_message(target) : pass_message(target)
  end

  #
  #
  #
  def pass_message(target)
    standard_message(target)
  end

  #
  #
  #
  def fail_message(target)
    "! " + pass_message(target)
  end

  alias_method :==, :pass?
  alias_method :!=, :fail?

  alias_method :=~, :pass!
  alias_method :!~, :fail!

  alias_method :===, :pass!

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
  def complete_criteria(target)
    if i = @criteria.index(NA)
      @criteria[0...i] + [target] + @criteria[i+1..-1]
    else
      [target] + @criteria
    end
  end

  #
  # Construct a standard error message.
  #
  def standard_message(target)
    args_inspect = [target, *@criteria].map{ |o| o.inspect }

    if args_inspect.any?{ |o| o.size > SIZE_LIMIT }
      args_pattern = [].inject('a'){ |a,c| a << c; c = c.succ; a }

      msg = ''   
      msg << "a.#{self.class.operator}(" + args_pattern[1..-1].join(',') + ")\n"
      msg << args_inspect.join("\n")
      msg
    else
      args_inspect.first + ".#{@operator}(" + args_inspect[1..-1].join(', ') + ")"
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
  # TODO: Don't care for Proc === target conditional code, but not
  # sure how else to deal with lambda targets.
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
    def pass?(target)
      if Proc === target && @block.nil?
        @assertion.pass?(*@criteria, &target)
      else
        @assertion.pass?(*complete_criteria(target), &@block)
      end
    end

    #
    def fail?(target)
      if Proc === target && @block.nil?
        @assertion.fail?(*@criteria, &target)
      else
        @assertion.fail?(*complete_criteria(target), &@block)
      end
    end

    #
    def pass!(target)
      if Proc === target && @block.nil?
        @assertion.pass!(*@criteria, &target)
      else
        @assertion.pass!(*complete_criteria(target), &@block)
      end
    end

    #
    def fail!(target)
      if Proc === target && @block.nil?
        @assertion.fail!(*@criteria, &target)
      else
        @assertion.fail!(*complete_criteria(target), &@block)
      end
    end

    alias_method :==, :pass?
    alias_method :!=, :fail?

    alias_method :=~, :pass!
    alias_method :!~, :fail!

    alias_method :===, :pass!

    #
    def pass_message(target)
      @assertion.pass_message(*complete_criteria(target))
    end

    #
    def fail_message(target)
      @assertion.fail_message(*complete_criteria(target))
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
    #def exception(target, msg=nil)
    #  @assertion.new(msg || message, target, *@criteria, &@block)     
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

    def complete_criteria(target)
      if i = @criteria.index(__)
        @criteria[0...i] + [target] + @criteria[i+1..-1]
      else
        [target] +  @criteria
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

