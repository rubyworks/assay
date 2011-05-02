require 'ansi/diff'

module Assay

  #
  class Failure < Exception #< Assertion

    # When displaying errors, use this as a rule of thumb
    # for determining when the inspected object will be too
    # big for a single line message.
    SIZE_LIMIT = 13

    #
    def initialize(message, options={})
      super(message)
      set_backtrace  options[:backtrace] if options[:backtrace]
      set_arguments *options[:arguments] if options[:arguments]
      set_negated    options[:negated]   if options[:negated]
    end

    #
    def self.assertable_method
      "assert_#{assertion_name}"
    end

    #
    def self.assert(*args, &blk)
      opts = Hash === args.last ? args.pop : {}
      chk  = check(*args, &blk)
      msg  = fail_message(*args, &blk)
      fail new(opts[:message]||msg, opts[:backtrace]||caller) unless chk
    end

    #
    def self.assert!(*args, &blk)
      opts = Hash === args.last ? args.pop : {}
      chk  = check!(*args, &blk)
      msg  = fail_message!(*args, &blk)
      fail new(opts[:message]||msg, opts[:backtrace]||caller) unless chk
    end

    #
    def self.check(*args, &blk)
      raise NotImplementedError
    end

    #
    def self.check!(*args, &blk)
      ! check(*args, &blk)
    end

    ##
    #def self.fail_message(*)
    #  raise NotImplementedError
    #end

    #
    #def self.fail_message!(*args)
    #  "NOT " + fail_message(*args)
    #end

    # Returns a Matcher for the failure class.
    def self.to_matcher(*args, &blk)
      Matcher.new(self, *args, &blk)
    end

    # Failure is, of course, always a type of assertion.
    #
    # This allows Assay's classes to work in any test framework
    # supporting this interface, such as QED.
    def assertion?
      true
    end

    # Set whether this failure was the inverse of it's normal meaning.
    # FOr example, `!=` rather than `==`.
    def set_negated(negated)
      @_negated = !!negated
    end

    # Set arguments used to make assertion.
    def set_arguments(*arguments)
      @_arguments = arguments
    end

    #
    def to_s
      if @_negated
        "NOT " + super()
      else
        super()
      end
    end

  end

  #
  class Matcher
    def initialize(failure, *args, &blk)
      @failure_class = failure
      @args = args
      @blk  = blk
    end

    def matches?(target)
      @target = target
      @failure_class.check(target, *@args, &@blk)
    end

    def fail_message
      @failure_class.fail_message(@target, *@args, &@blk)
    end

    def negative_fail_message
      @failure_class.fail_message!(@target, *@args, &@blk)
    end

    def failure_class
      @failure_class
    end

    def fail(backtrace=nil)
      msg = fail_message
      super failure_class.new(msg, backtrace||caller)
    end
  end

end
