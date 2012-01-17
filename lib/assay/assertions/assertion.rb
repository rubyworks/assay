require 'ansi/diff'
#require 'assay/matcher'

class Exception

  #
  # This method allows Assay's classes to work in any test framework
  # that supports this interface.
  #
  def assertion?
    @assertion
  end

  #
  # Set assertion flag.
  #
  def set_assertion(boolean)
    @assertion = boolean ? true : false
  end

end


#
class Assertion < Exception

  # When displaying errors, use this as a rule of thumb
  # for determining when the inspected object will be too
  # big for a single line message.
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
  # The assertive name is used for the construction of assertive nomenclatures
  # such as `assert_equal`.
  # 
  def self.assertive_name
    name.split('::').last.chomp('assay').downcase
  end

  #
  # Singleton instance of class. By reusing the same instance, we can
  # speed up assertion execution significantly.
  #
  def self.instance(message=nil)
    @instance ||= new(message)
  end

  #
  def self.pass?(*arguments, &block)
    instance.pass?(*arguments, &block)
  end

  #
  def self.fail?(*arguments, &block)
    instance.fail?(*arguments, &block)
  end

  #
  def self.pass!(*arguments, &block)
    instance.pass!(*arguments, &block)
  end

  #
  def self.assert(*arguments, &block)
    instance.assert(*arguments, &block)
  end

  #
  def self.fail!(*arguments, &block)
    instance.fail!(*arguments, &block)
  end

  #
  def self.refute(*arguments, &block)
    instance.refute(*arguments, &block)
  end

  #
  #
  #
  def initialize(message=nil)
    #options = (Hash === arguments.last ? arguments.pop : {})

    @assertion = true

    super(message) if message

    #message ? super(message % arguments) : super()
    #set_backtrace(options[:backtrace]) if options[:backtrace]
    #set_negative(options[:negated])   if options[:negated]
  end

  #
  # Check the assertion, return `true` if passing, `false` otherwise.
  #
  def pass?(*args, &blk)
    raise NotImplementedError
  end

  #
  # Check the assertion, return `true` if failing, `false` otherwise.
  #
  def fail?(*args, &blk)
    ! pass?(*args, &blk)
  end

  #
  # Test the assertion, raising the exception if failing.
  #
  def pass!(*arguments, &block)
    options = (Hash === arguments.last ? arguments.pop : {})

    backtrace = options[:backtrace] || caller
    message   = options[:message]   || message(*arguments)

    unless pass?(*arguments, &block)
      fail self, message, backtrace
    end
  end

  alias assert pass!

  #
  # Test the refutation of the assertion.
  #
  # Test the inverse assertion, raising the exception if not failing.
  #
  def fail!(*arguments, &block)
    options = (Hash === arguments.last ? arguments.pop : {})

    backtrace = options[:backtrace] || caller
    message   = options[:message]   || message(*arguments)

    unless fail?(*arguments, &block)
      fail self, message, backtrace
    end
  end

  alias refute fail!


# FIXME

  #
  def negative?
    @negative
  end

  #
  # Set message.
  #
  def set_message(msg)
    @mesg = msg.to_str
  end

  ##
  ## Set whether this failure was the inverse of it's normal meaning.
  ## For example, `!=` rather than `==`.
  ##
  #def set_negative(negative)
  #  @negative = !!negative
  #end

  ##
  ## Set arguments used to make assertion.
  ##
  #def set_arguments(*arguments, &block)
  #  @arguments = arguments
  #  @block     = block
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
    def initialize(fail_class, *arguments, &block)
      @fail_class = fail_class
      @arguments  = arguments
      @block      = block
    end

    #
    def fail_class
      @fail_class
    end

    #
    def pass?(target)
      if Proc === target && @block.nil?
        @fail_class.pass?(*@arguments, &target)
      else
        @fail_class.pass?(target, *@arguments, &@block)
      end
    end

    alias_method :=~, :pass?

    #
    def fail?(target)
      if Proc === target && @block.nil?
        @fail_class.fail?(*@arguments, &target)
      else
        @fail_class.fail?(target, *@arguments, &@block)
      end
    end

    #
    def pass!(target)
      if Proc === target && @block.nil?
        @fail_class.pass!(*@arguments, &target)
      else
        @fail_class.pass!(target, *@arguments, &@block)
      end
    end

    alias_method :===, :pass!

    #
    def fail!(target)
      if Proc === target && @block.nil?
        @fail_class.fail!(*@arguments, &target)
      else
        @fail_class.fail!(target, *@arguments, &@block)
      end
    end

    #
    #def ===(target)
    #  raise(fail_class.new(nil, target, *@arguments, &@block)) unless self =~ target
    #end

    #
    #
    #
    def message(target)
      @fail_class.message % [target, *@arguments]
    end

    #
    #def negated_message(target)
    #  @fail_class.message % [target, *@arguments]
    #end

    #
    # Returns Exception instance.
    #
    def exception(target, msg=nil)
      @fail_class.new(msg || message, target, *@arguments, &@block)     
      #  :negated   => options[:negated],
      #  :backtrace => options[:backtrace] || caller,
    end

    ##
    #def fail(*args)
    #  super(self, *args)
    #end

    # rspec matcher compatability

    alias matches? pass?

    alias does_not_match? fail?

    alias failure_message_for_should message

    alias failure_message_for_should_not message  # TODO

  end

end

