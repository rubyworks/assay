require 'assertions/failures/delta'

module Assertable

  # Passes if expected_float and actual_float are equal within delta tolerance.
  #
  #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
  #
  def assert_in_delta(exp, act, delta, opts={})
    opts[:backtrace] ||= caller
    DeltaFailure.assert(exp, act, delta, opts)
  end

  # Passes if expected_float and actual_float are equal not within delta tolerance.
  #
  #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
  #
  def self.not_in_delta(exp, act, delta, opts)
    opts[:backtrace] ||= caller
    DeltaFailure.assert!(exp, act, delta, opts)
  end

end
