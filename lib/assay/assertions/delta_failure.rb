require 'assay/assertions/compare_failure'

module Assay

  # TODO: Support Range for Delta comparisons.

  #
  class DeltaFailure < CompareFailure

    #
    def self.assertion_name
      :in_delta
    end

    # Check assertion.
    def self.pass?(act, exp, delta)
      case delta
      when Numeric
        (exp.to_f - act.to_f).abs <= delta.to_f
      else
        exp - act <= delta
      end
    end

    #
    def to_s
      return @mesg if @mesg
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

end
