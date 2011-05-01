require 'assay/compare_failure'

module Assay

  class IdentityFailure < CompareFailure

    def self.assertion_name
      :identical
    end

    def self.assertion_operator
      :equal?
    end

    def self.fail_message(exp, act)
      "Expected #{act.inspect} to be identical to #{exp.inspect}"
    end

    def self.fail_message!(exp, act)
      "Expected #{act.inspect} not to be identical to #{exp.inspect}"
    end

    def self.check(exp, act)
      exp.object_id == act.object_id
    end

    def self.check!(exp, act)
      exp.object_id != act.object_id
    end

  end


  module Assertable
    # Passes if +actual+ .equal? +expected+ (i.e. they are the same instance).
    #
    #   o = Object.new
    #   assert_identical(o, o)
    #
    def assert_identical(exp, act, opts={})
      opts[:backtrace] ||= caller
      IdentityFailure.assert(exp, act, opts)
    end

    # Passes if ! actual .equal? expected
    #
    #   assert_not_identical(Object.new, Object.new)
    #
    def assert_not_identical(exp, act, opts={})
      opts[:backtrace] ||= caller
      IdentityFailure.assert!(exp, act, opts)
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
