require 'ansi/diff'

module Assay

  #
  class Failure < Exception #< Assertion

    # When displaying errors, use this as a rule of thumb
    # for determining when the inspected object will be too
    # big for a single line message.
    SIZE_LIMIT = 13

    # Returns a Matcher for the failure class.
    def self.to_matcher(*args, &blk)
      Matcher.new(self, *args, &blk)
      #matcher = new
      #matcher.set_arguments(args, &blk)
      #matcher
    end

    #
    def self.assertable_method
      "assert_#{assertion_name}"
    end

    #
    def self.assert(*args, &blk)
      opts = Hash === args.last ? args.pop : {}

      backtrace = opts[:backtrace] || caller
      message   = opts[:message]

      err = new(message, *args, &blk)
      err.set_backtrace(backtrace)
      err.assert

      #chk  = check(*args, &blk)
      #msg  = fail_message(*args, &blk)
      #if !chk
      #  msg = opts[:message]
      #  btr = opts[:backtrace] || caller
      #  err = new(msg, *args)
      #  err.set_backtrace(btr)
      #  fail err
      #end
    end

    #
    def self.refute(*args, &blk)
      opts = Hash === args.last ? args.pop : {}

      backtrace = opts[:backtrace] || caller
      message   = opts[:message]

      err = new(message, *args, &blk)
      err.set_backtrace(backtrace)
      err.set_negative(true)
      err.assert

      #opts = Hash === args.last ? args.pop : {}
      #chk  = check!(*args, &blk)
      ##msg  = fail_message!(*args, &blk)
      #if !chk
      #  msg = opts[:message]
      #  btr = opts[:backtrace] || caller
      #  err = new(msg, :backtrace=>btr, :arguments=>args)
      #  fail err
      #end
    end

    #
    def self.pass?(*args, &blk)
      raise NotImplementedError
    end

    #
    def self.fail?(*args, &blk)
      ! pass?(*args, &blk)
    end

    ##
    #def self.fail_message(*)
    #  raise NotImplementedError
    #end

    #
    #def self.fail_message!(*args)
    #  "NOT " + fail_message(*args)
    #end

    #
    def initialize(message=nil, *arguments, &block)
      message ? super(message % arguments) : super()

      @arguments = arguments
      @block     = block

      #set_arguments options[:arguments] if options[:arguments]
      #set_negative  options[:negated]   if options[:negated]
      #set_backtrace options[:backtrace] if options[:backtrace]
    end

    # Failure is always a type of assertion.
    #
    # This method allows Assay's classes to work in any test framework
    # that supports this interface.
    def assertion?
      true
    end

    #
    def valid?
      self.class.pass?(*@arguments, &@block)
    end

    #
    def invalid?
      not valid?
    end

    #
    def assert
      raise self unless valid?
    end

    #
    def refute
      raise self unless invalid?
    end

    #
    def negative?
      @negative
    end

    # Set whether this failure was the inverse of it's normal meaning.
    # For example, `!=` rather than `==`.
    def set_negative(negative)
      @negative = !!negative
    end

    # Set arguments used to make assertion.
    def set_arguments(arguments)
      @arguments = arguments
      #@block    = block
    end

    #
    def to_s
      if @negative
        "NOT " + super()
      else
        super()
      end
    end

    #
    #def matches?(target)
    #  #@target = target
    #  self.class.check(target, *@_arguments, &@_block)
    #end

  end

  #
  class Matcher
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
    def matches?(target)
      @exception = nil
      @target    = target

      @fail_class.pass?(target, *@arguments, &@block)
    end

    # Returns Exception class.
    def exception
      @exception ||= fail_class.new(nil, @target, *@arguments, &@block)     
      #  :negated   => options[:negated],
      #  :backtrace => options[:backtrace] || caller,
    end

    # This is just for RSpec matcher compatability.
    def fail_message
      exception.to_s
    end

    # This is just for RSpec matcher compatability.
    def negative_fail_message
      #exception.set_negative(true)
      exception.to_s
    end

    #
    def fail(backtrace=nil)
      super exception #(backtrace || caller)
    end
  end

end
