module Assay

  #
  class Failure < Exception #< Assertion

    #
    def initialize(message, backtrace=nil)
      super(message)
      set_backtrace(backtrace) if backtrace
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

    #
    def self.fail_message(*)
      raise NotImplementedError
    end

    #
    def self.fail_message!(*args)
      "NOT " + fail_message(*args)
    end

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
