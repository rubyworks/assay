require 'assay/assertion'

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
      if @_negated
        "Expected procedure to raise an exception"
      else
        "Expected procedure to execute successfully"
      end
    end

  end


  module Assertives
    # Passes if the block yields successfully.
    #
    # assert_executes "Couldn't do the thing" do
    #   do_the_thing
    # end
    #
    def assert_executes(opts={}, &blk)
      opts[:backtrace] ||= caller
      ExecutionFailure.assert(opts, &blk)
    end

    # Passes if the block does not yield successfully.
    #
    # assert_not_executes "Couldn't do the thing" do
    #   do_the_thing
    # end
    #
    def assert_not_executes(opts={}, &blk)
      opts[:backtrace] ||= caller
      ExecutionFailure.refute(opts, &blk)
    end
  end


  module Matchers
    # TODO: Reasonable matcher for ExectuionFailure ?
    #
    #
    #   proc.assert is_executed(*args)
    #
    def is_executed(&block)
      ExecutionFailure.to_matcher(&block)
    end

    #
    #
    #   proc.should be_executed(*args)
    #
    def be_extecuted(&block)
      ExecutionFailure.to_matcher(&block)
    end
  end

end
