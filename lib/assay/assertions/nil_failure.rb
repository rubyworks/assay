require 'assay/assertions/compare_failure'

module Assay

  class NilFailure < CompareFailure

    def self.assertion_name
      :nil
    end

    def self.assertion_operator
      :nil?
    end

    # Check assertion.
    def self.pass?(exp)
      exp.nil?
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be nil"
      else
        "Expected #{exp} to be nil"
      end
    end

  end

end
