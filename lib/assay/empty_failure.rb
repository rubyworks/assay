require 'assay/failure'

module Assay

  class EmptyFailure < Failure

    def self.assertion_name
      :empty
    end

    def self.assertion_operator
      :empty?
    end

    def self.fail_message(exp)
      "Expected #{exp.inspect} to be empty"
    end

    def self.fail_message!(exp)
      "Expected #{exp.inspect} to NOT be empty"
    end

    def self.check(exp)
      exp.empty?
    end

    def self.check!(exp)
      ! exp.empty?
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
      EmptyFailure.assert!(exp, opts)
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

