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

end
