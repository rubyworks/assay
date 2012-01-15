require 'assertions/failures/false'

module Assertable

  # Passed if object is +false+.
  #
  def assert_false(exp, opts={})
    opts[:backtrace] ||= caller
    FalseFailure.assert(exp, opts)
  end

  # Passed if object is not +false+.
  #
  #   assert_not_false(false)
  #
  def assert_not_false(exp, opts={})
    opts[:backtrace] ||= caller
    FalseFailure.assert!(exp, opts)
  end

end
