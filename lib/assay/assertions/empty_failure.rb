require 'assay/assertion'

module Assay

  # Empty assertion tests an object with `#empty?` method.
  #
  class EmptyFailure < Assertion
    #
    def self.assertion_name
      :empty
    end

    def self.assertion_operator
      :empty?
    end

    # Check assertion.
    def self.pass?(exp)
      exp.empty?
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments.first.inspect

      if @_negated
        "Expected #{exp} to NOT be empty"  
      else
        "Expected #{exp} to be empty"
      end
    end
  end

end

