require 'assay/failure'

module Assay

  #NoArgument = Object.new

  # TODO: What's up with N/A? Use Facets' NA object.
  class ReturnFailure < Failure

    def self.assert(exp, opts={}, &blk) #:yeild:
      msg = fail_message(exp)
      res = yield
      if :"N/A" == exp
        chk = (res ? true : false)
      else
        chk = (exp == res)
        msg = msg + ", but was #{res}"
      end
      fail new(opts[:message]||msg, opts[:backtrace]||caller) unless chk
    end

    def self.assert!(exp, opts={}, &blk) # :yield:
      msg = fail_message!(exp)
      res = yield
      if :"N/A" == exp
        chk = (res ? false : true)
      else
        chk = (exp != res)
        msg = msg + ", but was #{res}"
      end
      fail new(opts[:message]||msg, opts[:backtrace]||caller) unless chk
    end

    def self.fail_message(exp)
      if :"N/A" == exp
        "Expected block to return a value"
      else
        "Expected block to return #{exp}"
      end
    end

    def self.fail_message!(exp)
      if :"N/A" == exp
        "Expected block not to return a value"
      else
        "Expected block not to return #{exp}"
      end
    end

    def self.check(exp) #:yield:
      case exp
      when :"N/A"
        yield ? true : false
      else
        exp == yield
      end
    end

  end


  module Assertable

    # Passes if the block yields a specified value (Compares with #==).
    #
    # assert_returns "Did not return something" do
    #   do_the_thing
    # end
    #
    def assert_returns(exp=:"N/A", opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ReturnFailure.assert(exp, opts, &blk)
    end

    # Passes if the block does not yield a specific value.
    #
    # assert_does_not_return "Returned something unwanted" do
    #   do_the_thing
    # end
    #
    def assert_does_not_return(exp=:"N/A", opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ReturnFailure.assert!(exp, opts, &blk)
    end

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
