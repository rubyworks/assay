require 'assay/failure'
require 'assay/compare_failure'

module Assay

  class MatchFailure < CompareFailure

    def self.assertion_name
      :match
    end

    def self.assertion_operator
      :=~
    end

    # Check assertion.
    def self.pass?(exp, act)
      exp =~ act
    end

    # Check negated assertion.
    def self.fail?(exp, act)
      exp !~ act
    end

    #
    def self.assertable_method
      :assert_match
    end

    #
    def to_s
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect
      act = @arguments[1].inspect

      if @_negated
        "Expected #{act} !~ #{exp}"
      else
        "Expected #{act} =~ #{exp}"
      end
    end

  end


  module Assertable
    # Passes if string =~ pattern.
    #
    #   assert_match(/\d+/, 'five, 6, seven')
    #
    def assert_match(exp, act, opts={})
      opts[:backtrace] ||= caller
      MatchFailure.assert(exp, act, opts)
    end

    # Passes if regexp !~ string
    #
    #   refute_match(/two/, 'one 2 three')
    #
    def refute_match(exp, act, opts={})
      opts[:backtrace] ||= caller
      MatchFailure.refute(exp, act, opts)
    end
  end


  module Matchers
    #
    #
    #   object.assert is_a_match_for(regexp)
    #
    def is_match_for(regexp)
      MatchFailure.to_matcher(regexp)
    end

    #
    #
    #   object.should be_a_match_for(regexp)
    #
    def be_match_for(regexp)
      MatchFailure.to_matcher(regexp)
    end
  end

end
