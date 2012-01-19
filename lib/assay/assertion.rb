require 'ansi/diff'  # ANSI color output support

require_relative 'core_ext/na'
require_relative 'core_ext/exception'

#
class Assertion < Exception

  $ASSERTION_COUNTS ||= {:total=>0,:pass=>0,:fail=>0}

  #
  # When displaying errors, use this as a rule of thumb
  # for determining when the inspected object will be too
  # big for a single line message.
  #
  SIZE_LIMIT = 13

  #
  # Returns Matcher for the failure class.
  #
  def self.to_matcher(*args, &blk)
    Matcher.new(self, *args, &blk)
  end

  #
  # Alias for #to_matcher.
  #
  def self.[](*args, &blk)
    Matcher.new(self, *args, &blk)
  end

  #
  # If the assertion coresponds to a regular method, particular a symbolic
  # operator (hence the name of this method) then it should be specified via
  # this interface. Otherwise, it should be given a fitting "make believe"
  # method name and specified here.
  #
  def self.operator
    raise NotImplementedError
  end

  #
  # When Assertion is inherited, a table is kept index by assertion operator.
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
    operator = operator.to_sym if operator

    @@by_operator ||= (
      hash = {}
      subclasses.each do |c|
        if op = c.operator
          hash[op.to_sym] = c
        end
      end
      hash
    )

    operator ? @@by_operator[operator.to_sym] : @@by_operator
  end

  #
  # If operator is not given, returns a hash table of assertion classes
  # indexed by assertive name.
  #
  def self.by_name(name=nil)
    name = name.to_sym if name

    @@by_name ||= (
      hash = {}
      subclasses.each do |c|
        if op = c.assertive_name
          hash[op.to_sym] = c
        end
      end
      hash
    )

    name ? @@by_name[name.to_sym] : @@by_name
  end

  #
  # The assertive name is used for the construction of assertive nomenclatures
  # such as `assert_equal`.
  # 
  def self.assertive_name
    name.split('::').last.chomp('assay').downcase
  end

  #
  # Check the assertion, return `true` if passing, `false` otherwise.
  #
  def self.pass?(*args, &blk)
    raise NotImplementedError
  end

  #
  # Check the assertion, return `true` if failing, `false` otherwise.
  #
  def self.fail?(*args, &blk)
    ! pass?(*args, &blk)
  end

  #
  # Test the assertion, raising the exception if failing.
  #
  def self.pass!(*arguments, &block)
    options = (Hash === arguments.last ? arguments.pop : {})

    backtrace = options[:backtrace] || caller
    message   = options[:message]   || pass_message(*arguments, &block)

    $ASSERTION_COUNTS[:total] += 1

    if pass?(*arguments, &block)
      $ASSERTION_COUNTS[:pass] += 1
    else
      $ASSERTION_COUNTS[:fail] += 1
      fail self, message, backtrace
    end
  end

  # Alias for `#pass!`.
  def self.assert(*arguments, &block)
    pass!(*arguments, &block)
  end

  #
  # Test the refutation of the assertion.
  #
  # Test the inverse assertion, raising the exception if not failing.
  #
  def self.fail!(*arguments, &block)
    options = (Hash === arguments.last ? arguments.pop : {})

    backtrace = options[:backtrace] || caller
    message   = options[:message]   || fail_message(*arguments, &block)

    $ASSERTION_COUNTS[:total] += 1

    if fail?(*arguments, &block)
      $ASSERTION_COUNTS[:pass] += 1
    else
      $ASSERTION_COUNTS[:fail] += 1
      fail self, message, backtrace
    end
  end

  # Alias for `#fail!`.
  def self.refute(*arguments, &block)
    fail!(*arguments, &block)
  end

  #
  def self.pass_message(*arguments, &block)
    "#{name}.assert " + arguments.inspect
  end

  #
  def self.fail_message(*arguments, &block)
    "! " + pass_message(*arguments, &block)
  end

  #
  #
  #
  def initialize(message=nil)
    super(message)
    set_assertion(true)
    #options = (Hash === arguments.last ? arguments.pop : {})
    #set_backtrace(options[:backtrace]) if options[:backtrace]
    #set_negative(options[:negated])    if options[:negated]
  end

  ##
  #def pass_message(*arguments)
  #  return @mesg if @mesg
  #  message(*arguments)
  #end

  #
  #def fail_message(*arguments)
  #  msg = @mesg ? @mesg : pass_message(*arguments)
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
    def initialize(assertion, *arguments, &block)
      @assertion = assertion
      @arguments = arguments
      @block     = block
    end

    #
    def assertion
      @assertion
    end

    #
    def pass?(target)
      if Proc === target && @block.nil?
        @assertion.pass?(*@arguments, &target)
      else
        @assertion.pass?(*complete_arguments(target), &@block)
      end
    end

    #
    def fail?(target)
      if Proc === target && @block.nil?
        @assertion.fail?(*@arguments, &target)
      else
        @assertion.fail?(*complete_arguments(target), &@block)
      end
    end

    #
    def pass!(target)
      if Proc === target && @block.nil?
        @assertion.pass!(*@arguments, &target)
      else
        @assertion.pass!(*complete_arguments(target), &@block)
      end
    end

    #
    def fail!(target)
      if Proc === target && @block.nil?
        @assertion.fail!(*@arguments, &target)
      else
        @assertion.fail!(*complete_arguments(target), &@block)
      end
    end

    alias_method :==, :pass?
    alias_method :!=, :fail?

    alias_method :=~, :pass!
    alias_method :!~, :fail!

    alias_method :===, :pass!

    #
    def pass_message(target)
      @assertion.pass_message(*complete_arguments(target))
    end

    #
    def fail_message(target)
      @assertion.fail_message(*complete_arguments(target))
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
    #  @assertion.new(msg || message, target, *@arguments, &@block)     
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

    def complete_arguments(target)
      if i = @arguments.index(__)
        @arguments[0...i] + [target] + @arguments[i+1..-1]
      else
        [target] +  @arguments
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

end
