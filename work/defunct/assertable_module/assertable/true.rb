require 'assertions/failures/true'

module Assertable

  # Passed if object is +true+.
  #
  def assert_true(exp, opts={})
    opts[:backtrace] ||= caller
    TrueFailure.assert(exp, opts)
  end

  # Passed if object is not +true+.
  #
  #   assert_not_true(false)
  #
  def assert_not_true(exp, opts={})
    opts[:backtrace] ||= caller
    TrueFailure.assert!(exp, opts)
  end

end

