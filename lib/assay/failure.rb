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
      raise
    end

    #
    def self.check!(*args, &blk)
      ! check(*args, &blk)
    end

    #
    def self.fail_message
      raise
    end

    #
    def self.fail_message!
      "NOT #{fail_message}"
    end

    # Returns a Matcher for the failure class.
    def self.to_matcher(*args, &blk)
      Matcher.new(self, *args, &blk)
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
      @failure_class.fail_message(@target, @args, &@blk)
    end

    def negative_fail_message
      @failure_class.fail_message!(@target, @args, &@blk)
    end
  end

end

