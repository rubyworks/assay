require 'assay/assertions/compare_failure'

module Assay

  class NilFailure < CompareFailure

    def self.assertion_name
      :nil
    end

    def self.assertion_operator
      :nil?
    end

    # Check assertion.
    def self.pass?(exp)
      exp.nil?
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be nil"
      else
        "Expected #{exp} to be nil"
      end
    end

  end


  module Assertives
    # Passed if object is +nil+.
    #
    def assert_nil(exp, msg=nil)
      NilFailure.assert(exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +nil+.
    #
    #   assert_not_nil(true)
    #
    def assert_not_nil(exp, msg=nil)
      opts[:backtrace] ||= caller
      NilFailure.refute(exp, :message=>msg, :backtrace=>caller)
    end
  end


  module Matchers

    #
    #
    #   value.assert is_nil
    #
    def is_nil
      NilFailure.to_matcher
    end

    #
    #
    #   value.should be_nil
    #
    def be_nil
      NilFailure.to_matcher
    end

  end

end
