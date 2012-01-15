require 'assertion'

module Assertable

  # Passes if the block yields successfully.
  #
  # assert_executes "Couldn't do the thing" do
  #   do_the_thing
  # end
  #
  def assert_executes(opts={}, &blk) # :yield:
    opts[:backtrace] ||= caller
    ExecutionFailure.assert(blk, opts)
  end

  # Passes if the block does not yield successfully.
  #
  # assert_not_executes "Couldn't do the thing" do
  #   do_the_thing
  # end
  #
  def assert_not_executes(opts={}, &blk) # :yield:
    opts[:backtrace] ||= caller
    ExecutionFailure.assert!(blk, opts)
  end

end
