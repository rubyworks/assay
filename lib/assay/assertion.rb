require 'ansi/diff'
require 'assay/matcher'

module Assay

  #
  class Assertion < Exception

    # When displaying errors, use this as a rule of thumb
    # for determining when the inspected object will be too
    # big for a single line message.
    SIZE_LIMIT = 13

    # Returns Matcher for the failure class.
    def self.to_matcher(*args, &blk)
      Matcher.new(self, *args, &blk)
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
      err.refute

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
      true  # @assertion = true if @assertion.nil?
    end

    #
    def pass?
      self.class.pass?(*@arguments, &@block) #^ @negative
    end

    #
    def fail?
      not pass?
    end

    #
    def assert
      #@negative = false
      raise self unless pass?
    end

    #
    def refute
      #@negative = true
      raise self unless fail?
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

  end

end
