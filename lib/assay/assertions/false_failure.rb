require 'assay/assertions/compare_failure'

module Assay

  class FalseFailure < CompareFailure

    def self.assertion_name
      :false
    end

    def self.assertion_operator
      :false?
    end

    # Check assertion.
    def self.pass?(exp)
      FalseClass === exp
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be false"
      else
        "Expected #{exp} to be false"
      end
    end

  end


  module Assertives
    # Passed if object is +false+.
    #
    def assert_false(exp, msg=nil)
      FalseFailure.assert(exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +false+.
    #
    #   assert_not_false(false)
    #
    def assert_not_false(exp, msg=nil)
      FalseFailure.refute(exp, :message=>msg, :backtrace=>caller)
    end
  end


  module Matchers
    #
    #
    #   value.assert is_false
    #
    def is_false
      FalseFailure.to_matcher
    end

    #
    #
    #   value.should be_false
    #
    def be_false
      FalseFailure.to_matcher
    end
  end

end
