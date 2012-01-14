require 'assay/assertions/compare_failure'

module Assay

  class InstanceFailure < CompareFailure

    def self.assertion_name
      :instance
    end

    def self.assertion_operator
      :instance_of?
    end

    # Check assertion.
    def self.pass?(act, exp)
      act.instance_of?(exp)
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect
      act = @arguments[1].inspect

      if @_negated
        "Expected #{act} to NOT be an instance of #{exp}"  
        else
        "Expected #{act} to be an instance of #{exp}"
      end
    end
  end

end
