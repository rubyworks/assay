require 'assertions/failures/identity'

module Assertable

  # Passes if +actual+ .equal? +expected+ (i.e. they are the same instance).
  #
  #   o = Object.new
  #   assert_identical(o, o)
  #
  def assert_identical(exp, act, opts={})
    opts[:backtrace] ||= caller
    IdentityFailure.assert(exp, act, opts)
  end

  # Passes if ! actual .equal? expected
  #
  #   assert_not_identical(Object.new, Object.new)
  #
  def assert_not_identical(exp, act, opts={})
    opts[:backtrace] ||= caller
    IdentityFailure.assert!(exp, act, opts)
  end

end
