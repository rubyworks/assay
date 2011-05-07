require 'assay/assertions/compare_failure'

module Assay

  # Comparison assertion for TrueClass.
  #
  #   TrueFailure.pass?(true) #=> true
  #   TrueFailure.fail?(true) #=> false
  #   TrueFailure.pass?(1)    #=> false
  #
  class TrueFailure < CompareFailure

    def self.assertion_name
      :true
    end

    def self.assertion_operator
      :true?
    end

    # Check assertion.
    def self.pass?(exp)
      TrueClass === exp
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be true"
      else
        "Expected #{exp} to be true"
      end
    end

  end


  module Assertives
    # Passed if object is +true+.
    #
    def assert_true(exp, msg=nil)
      TrueFailure.assert(exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +true+.
    #
    #   assert_not_true(false)
    #
    def assert_not_true(exp, msg=nil)
      TrueFailure.refute(exp, :message=>msg, :backtrace=>caller)
    end
  end


  module Matchers
    # True?
    #
    #   value.assert is_true
    #
    def is_true
      TrueFailure.to_matcher
    end

    # True?
    #
    #   value.should be_true
    #
    def be_true
      TrueFailure.to_matcher
    end
  end

end

