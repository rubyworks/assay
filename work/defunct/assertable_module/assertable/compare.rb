module Assertable

  # Passes if +actual+ .equte? +expected+.
  #
  #   o = Object.new
  #   assert_like(o, o)
  #
  def self.like(exp, act, opts={})
    opts[:backtrace] ||= caller
    CompareFailure.assert(exp, act, opts)
  end

  # Passes if ! actual .equte? expected
  #
  #   assert_not_like(Object.new, Object.new)
  #
  def self.not_like(exp, act, opts)
    opts[:backtrace] ||= caller
    CompareFailure.assert(exp, act, opts)
  end

end
