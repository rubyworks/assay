module Assay

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
    def exception(message=nil)
      @exception ||= fail_class.new(message, @target, *@arguments, &@block)     
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
