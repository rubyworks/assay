require 'assay/failure'

module Assay

  #NoArgument = Object.new

  # DEPRECATE: This class has little value. Instead of doing
  #
  #   assert_returns(4){ v }
  #
  # Simply test equality on the returned value.
  #
  #   assert_equal(4, v)
  #
  # TODO: What's up with N/A? Use Facets' NA object?
  class ReturnFailure < Failure

    #
    def self.assert(exp, opts={}, &blk) #:yeild:
      #msg = fail_message(exp)
      res = yield
      if :"N/A" == exp
        chk = (res ? true : false)
        args = [exp]
      else
        chk = (exp == res)
        #msg = msg + ", but was #{res}"
        args = [exp, res]
      end
      if !chk
        msg = opts[:message]
        bkt = opts[:backtrace] || caller
        fail new(msg, :backtrace=>bkt, :arguments=>args)
      end
    end

    #
    def self.refute(exp, opts={}, &blk) # :yield:
      #msg = fail_message!(exp)
      res = yield
      if :"N/A" == exp
        chk = (res ? false : true)
        args = [exp]
      else
        chk = (exp != res)
        #msg = msg + ", but was #{res}"
        args = [exp, res]
      end
      if !chk
        msg = opts[:message]
        bkt = opts[:backtrace] || caller
        fail new(msg, :backtrace=>bkt, :arguments=>args)
      end
    end

    # Check assertion.
    def self.check(exp) #:yield:
      case exp
      when :"N/A"
        yield ? true : false
      else
        exp == yield
      end
    end

    #
    def to_s
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect

      if @_negated
        if :"N/A" == exp
          "Expected block NOT to return a value"
        else
          "Expected block NOT to return #{exp}"
        end
      else
        if :"N/A" == exp
          "Expected block to return a value"
        else
          "Expected block to return #{exp}"
        end
      end
    end

  end


  module Assertable

    # Passes if the block yields a specified value (Compares with #==).
    #
    # assert_returns "something wanted" do
    #   do_the_thing
    # end
    #
    def assert_returns(exp=:"N/A", opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ReturnFailure.assert(exp, opts, &blk)
    end

    # Passes if the block does not yield a specific value.
    #
    # refute_returns "something unwanted" do
    #   do_the_thing
    # end
    #
    def refute_returns(exp=:"N/A", opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ReturnFailure.refute(exp, opts, &blk)
    end

    alias_method :assert_does_not_return, :refute_returns
  end


  module Matchers
    #
    #
    #   object.assert is_returned{ ... }
    #
    def is_returned(&blk)
      ReturnFailure.to_matcher(&blk)
    end

    #
    #
    #   object.should be_returned{ ... }
    #
    def be_returned(&blk)
      ReturnFailure.to_matcher(&blk)
    end
  end

end
