require 'assay/assertion'

module Assay

  class EmptyFailure < Assertion

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
      return @mesg if @mesg
      return super unless @arguments.size == 1

      exp = @arguments.first.inspect

      if @_negated
        "Expected #{exp} to NOT be empty"  
      else
        "Expected #{exp} to be empty"
      end
    end

  end


  module Assertives
    # Passed if object is +true+.
    #
    def assert_empty(exp, msg=nil)
      EmptyFailure.assert(exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +true+.
    #
    #   assert_not_true(false)
    #
    def refute_empty(exp, msg=nil)
      opts[:backtrace] ||= caller
      EmptyFailure.refute(exp, :message=>msg, :backtrace=>caller)
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

