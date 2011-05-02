require 'assay/failure'

module Assay

  class CompareFailure < Failure

    def self.assertion_name
      :like
    end

    # Check assertion.
    def self.check(exp, act)
      exp.equals?(act) ||
      exp.eq?(act)     ||
      exp.==(act)      ||
      exp.===(act)
    end

    #
    def to_s
      return super unless @_arguments.size == 2

      iexp = @_arguments[0].inspect
      iact = @_arguments[1].inspect

      if @_negated
        "Expected #{iact} to NOT be like #{iexp}"
      else
        "Expected #{iact} to be like #{iexp}"
      end
    end

  end


  module Assertable

  end


  module Matchers
    #
    #
    #   object1.should be_like(object2)
    #
    def be_like(act)
      CompareFailure.to_matcher(act)
    end

    #
    #
    #   object1.should be_like(object2)
    #
    def is_like(act)
      CompareFailure.to_matcher(act)
    end
  end

end

