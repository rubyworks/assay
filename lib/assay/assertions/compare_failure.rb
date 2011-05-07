require 'assay/assertion'

module Assay

  class CompareFailure < Assertion

    def self.assertion_name
      :like
    end

    # Test assertion.
    def self.pass?(exp, act)
      exp.equal?(act) ||
      exp.eq?(act)    ||
      exp.==(act)     ||
      exp.===(act)
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      iexp = @arguments[0].inspect
      iact = @arguments[1].inspect

      if @_negated
        "Expected #{iact} to NOT be like #{iexp}"
      else
        "Expected #{iact} to be like #{iexp}"
      end
    end

  end


  module Assertives

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

