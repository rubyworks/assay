require 'assay/assertion'

# FIXME: This thing needs work!!!!!!!!!!!!


module Assay

  # Assert that a block of coded executes without error.
  #
  # ExecutionFailure is also the base class of the other
  # block-executing assertion classes.
  class ExecutionFailure < Assertion
    #
    def self.assertion_name
      :execution
    end

    # Check assertion.
    def self.pass?(_=nil, &block)
      begin
        block.call
        true
      rescue Exception
        false
      end
    end

    # Check negated assertion.
    def self.fail?(_=nil, &block)
      begin
        block.call
        false
      rescue Exception
        true
      end
    end

    #
    def to_s
      return @mesg if @mesg
      if @_negated
        "Expected procedure to raise an exception"
      else
        "Expected procedure to execute successfully"
      end
    end

  end

end
