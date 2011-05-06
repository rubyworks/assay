require 'assay/failure'

module Assay

  class EmptyFailure < Failure

    def self.assertion_name
      :empty
    end

    def self.assertion_operator
      :empty?
    end

    # Check assertion.
    def self.pass?(exp)
      exp.empty?
    end

    #
    def to_s
      return super unless @arguments.size == 1

      exp = @arguments.first.inspect

      if @_negated
        "Expected #{exp} to NOT be empty"  
      else
        "Expected #{exp} to be empty"
      end
    end

  end


  module Assertable
    # Passed if object is +true+.
    #
    def assert_empty(exp, opts={})
      opts[:backtrace] ||= caller
      EmptyFailure.assert(exp, opts)
    end

    # Passed if object is not +true+.
    #
    #   assert_not_true(false)
    #
    def refute_empty(exp, opts={})
      opts[:backtrace] ||= caller
      EmptyFailure.refute(exp, opts)
    end

    alias_method :assert_not_empty, :refute_empty
  end


  module Matchers
    # Empty?
    #
    #   object.assert is_true
    #
    def is_empty
      EmptyFailure.to_matcher
    end

    # Empty?
    #
    #   object.should be_empty
    #
    def be_empty
      EmptyFailure.to_matcher
    end
  end

end

