require 'assay/failure'

module Assay

  #
  class ExecutionFailure < Failure
    #
    def self.assertion_name
      :execution
    end

    def self.fail_message(&proc)
      "Expected procedure to execute successfully"
    end

    def self.fail_message!(&proc)
      "Expected procedure to raise an exception"
    end

    def self.check(proc=nil, &block)
      begin
        (proc || block).call
        true
      rescue Exception
        false
      end
    end

    def self.check!(&proc)
      begin
        proc.call
        false
      rescue Exception
        true
      end
    end
  end


  module Assertable
    # Passes if the block yields successfully.
    #
    # assert_executes "Couldn't do the thing" do
    #   do_the_thing
    # end
    #
    def assert_executes(opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ExecutionFailure.assert(opts, &blk)
    end

    # Passes if the block does not yield successfully.
    #
    # assert_not_executes "Couldn't do the thing" do
    #   do_the_thing
    # end
    #
    def assert_not_executes(opts={}, &blk) # :yield:
      opts[:backtrace] ||= caller
      ExecutionFailure.assert!(opts, &blk)
    end
  end


  module Matchers
    # TODO: Reasonable matcher for ExectuionFailure ?
    #
    #
    #   proc.assert is_executed(*args)
    #
    def is_executed(*args)
      ExecutionFailure.to_matcher(*args)
    end

    #
    #
    #   proc.should be_executed(*args)
    #
    def be_extecuted(*args)
      ExecutionFailure.to_matcher(*args)
    end
  end

end
