require 'assertions/failures/returns'

module Assertable

  # Passes if the block yields a specified value (Compares with #==).
  #
  # assert_returns "Did not return something" do
  #   do_the_thing
  # end
  #
  def assert_returns(exp=:"N/A", opts={}, &blk) # :yield:
    opts[:backtrace] ||= caller
    ReturnFailure.assert(exp, opts, &blk)
  end

  # Passes if the block does not yield a specific value.
  #
  # assert_does_not_return "Returned something unwanted" do
  #   do_the_thing
  # end
  #
  def assert_does_not_return(exp=:"N/A", opts={}, &blk) # :yield:
    opts[:backtrace] ||= caller
    ReturnFailure.assert!(exp, opts, &blk)
  end

end
