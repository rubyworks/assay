require 'assertions/failures/nil'

module Assertable

  # Passed if object is +nil+.
  #
  def assert_nil(exp, opts={})
    opts[:backtrace] ||= caller
    NilFailure.assert(exp, opts)
  end

  # Passed if object is not +nil+.
  #
  #   assert_not_nil(true)
  #
  def assert_not_nil(exp, opts={})
    opts[:backtrace] ||= caller
    NilFailure.assert!(exp, opts)
  end

end

