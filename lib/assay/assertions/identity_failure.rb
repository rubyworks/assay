require 'assay/assertions/compare_failure'

module Assay

  class IdentityFailure < CompareFailure

    def self.assertion_name
      :identical
    end

    def self.assertion_operator
      :equal?
    end

    #def self.fail_message(exp, act)
    #  "Expected #{act.inspect} to be identical to #{exp.inspect}"
    #end

    #def self.fail_message!(exp, act)
    #  "Expected #{act.inspect} not to be identical to #{exp.inspect}"
    #end

    # Check assertion.
    def self.pass?(exp, act)
      exp.object_id == act.object_id
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      iexp = @arguments[0].inspect
      iact = @arguments[1].inspect

      if @_negated
        "Expected #{iact} not to be identical to #{iexp}"
      else
        "Expected #{iact} to be identical to #{iexp}"
      end
    end

  end


  module Assertives
    # Passes if +actual+ .equal? +expected+ (i.e. they are the same instance).
    #
    #   o = Object.new
    #   assert_identical(o, o)
    #
    def assert_identical(exp, act, msg=nil)
      IdentityFailure.assert(exp, act, :message=>msg, :backtrace=>caller)
    end

    # Passes if ! actual .equal? expected
    #
    #   assert_not_identical(Object.new, Object.new)
    #
    def assert_not_identical(exp, act, msg=nil)
      IdentityFailure.refute(exp, act, :message=>msg, :backtrace=>caller)
    end
  end


  module Matchers
    #
    #
    #   object1.assert is_identical_to(object2)
    #
    def is_identical_to(obj)
      IdentityFailure.to_matcher(obj)
    end

    #
    #
    #   object1.should be_identical_to(object2)
    #
    def be_identical_to(obj)
      IdentityFailure.to_matcher(obj)
    end

  end

end
