require 'assay/compare_failure'

module Assay

  # TODO: Support Range
  class DeltaFailure < CompareFailure

    #
    def self.assertion_name
      :in_delta
    end

    # Check assertion.
    def self.pass?(exp, act, delta)
      case delta
      when Numeric
        (exp.to_f - act.to_f).abs <= delta.to_f
      else
        exp - act <= delta
      end
    end

    #
    def to_s
      return super unless @arguments.size == 3

      exp   = @arguments[0].inspect
      act   = @arguments[1].inspect
      delta = @arguments[2].inspect

      if @_negated
        "Expected #{exp} to NOT be within #{delta} of #{act}"
      else
        "Expected #{exp} to be within #{delta} of #{act}"
      end
    end

  end


  module Assertable
    # Passes if expected and actual are equal within delta tolerance.
    #
    #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def assert_in_delta(exp, act, delta, opts={})
      opts[:backtrace] ||= caller
      DeltaFailure.assert(exp, act, delta, opts)
    end

    # Passes if expected and actual are equal not within delta tolerance.
    #
    #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def self.not_in_delta(exp, act, delta, opts)
      opts[:backtrace] ||= caller
      DeltaFailure.refute(exp, act, delta, opts)
    end
  end


  module Matchers
    #
    #
    #   value1.should be_within(delta, value2)
    #
    def is_within(delta, act)
      DeltaFailure.to_matcher(act, delta)
    end

    #
    #
    #   value1.assert is_within(delta, value2)
    #
    def be_within(delta, act)
      DeltaFailure.to_matcher(act, delta)
    end
  end

end
