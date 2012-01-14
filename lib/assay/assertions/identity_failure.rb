require 'assay/assertions/compare_failure'

module Assay

  class IdentityFailure < CompareFailure

    def self.assertion_name
      :identical
    end

    def self.assertion_operator
      :equal?
    end

    #def self.fail_message(exp, act)
    #  "Expected #{act.inspect} to be identical to #{exp.inspect}"
    #end

    #def self.fail_message!(exp, act)
    #  "Expected #{act.inspect} not to be identical to #{exp.inspect}"
    #end

    # Check assertion.
    def self.pass?(act, exp)
      exp.object_id == act.object_id
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      iexp = @arguments[0].inspect
      iact = @arguments[1].inspect

      if @_negated
        "Expected #{iact} not to be identical to #{iexp}"
      else
        "Expected #{iact} to be identical to #{iexp}"
      end
    end

  end

end
