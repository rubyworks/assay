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

end

