require 'assertion/failures/match'

module Assertable

  # Passes if string =~ pattern.
  #
  #   assert_match(/\d+/, 'five, 6, seven')
  #
  def self.match(exp, act, opts={})
    opts[:backtrace] ||= caller
    MatchFailure.assert(exp, act, opts)
  end

  # Passes if regexp !~ string
  #
  #   assert_no_match(/two/, 'one 2 three')
  #
  def self.no_match(exp, act, opts={})
    opts[:backtrace] ||= caller
    MatchFailure.assert!(exp, act, opts)
  end

end
