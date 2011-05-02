require 'assay/compare_failure'

module Assay

  #
  class EqualityFailure < CompareFailure

    #
    def self.assertion_name
      :equal
    end

    #
    def self.assertion_operator
      :==
    end

    # Check assertion.
    def self.check(exp, act)
      exp == act
    end

    # Check negated assertion.
    def self.check!(exp, act)
      exp != act
    end

    #
    def to_s
      return super unless @_arguments.size == 2

      oper = @_negated ? "!=" : "=="
      iexp = @_arguments[0].inspect
      iact = @_arguments[1].inspect

      if iexp.size > SIZE_LIMIT or iact.size > SIZE_LIMIT
        diff = ANSI::Diff.new(iact, iexp)
        "x1 #{oper} x2\n1) #{diff.diff1}\n2) #{diff.diff2}"
      else
        "#{iact} #{oper} #{iexp}"
      end
    end

  end


  module Assertable
    # Passes if expected == +actual.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   assert_equal 'MY STRING', 'my string'.upcase
    #
    def assert_equal(exp, act, opts={})
      opts[:backtrace] ||= caller
      EqualityFailure.assert(exp, act, opts)
    end

    # Passes if expected != actual
    #
    #  assert_not_equal 'some string', 5
    #
    def assert_not_equal(exp, act, opts)
       opts[:backtrace] ||= caller
       EqualityFailure.assert!(exp, act, opts)
    end
  end


  module Matchers
    # Passes if +expected+ == +actual+.
    #
    #   'MY STRING'.assert is_equal_to('my string'.upcase)
    #   'MY STRING'.assert_not is_equal_to('another string')
    #
    def is_equal_to(exp, opts={})
      EqualityFailure.to_matcher(exp)
    end

    # Passes if +expected+ == +actual+.
    #
    #   'MY STRING'.should be_equal_to('my string'.upcase)
    #   'MY STRING'.should_not be_equal_to('another string')
    #
    def be_equal_to(exp)
      EqualityFailure.to_matcher(exp)
    end

    ## # Passes if expected != actual
    ## #
    ## #  'some string'.should not_be_equal_to('foo')
    ## #
    ## def not_be_equal_to(exp, act, opts)
    ##   opts[:backtrace] ||= caller
    ##   EqualityFailure.to_matcher!(exp, opts)
    ## end
  end

end
