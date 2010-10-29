require 'assay/compare_failure'

module Assay

  class InstanceFailure < CompareFailure

    def self.assertion_name
      :instance
    end

    def self.assertion_operator
      :instance_of?
    end

    def self.fail_message(exp, act)
      "Expected #{act.inspect} to be an instance of #{exp.inspect}"
    end

    def self.fail_message!(exp, act)
      "Expected #{act.inspect} to not be an instance of #{exp.inspect}"
    end

    def self.check(exp, act)
      exp.instance_of?(act)
    end

    def self.check!(exp, act)
      ! exp.instance_of?(act)
    end

  end


  module Assertable
    # Passes if object .instance_of? klass
    #
    #   assert_instance_of(String, 'foo')
    #
    def assert_instance_of(cls, obj, opts={})
      opts[:backtrace] ||= caller
      InstanceFailure.assert(cls, obj, opts)
    end

    # Passes if object .instance_of? klass
    #
    #   assert_instance_of(String, 'foo')
    #
    def refute_instance_of(cls, obj, opts={})
      opts[:backtrace] ||= caller
      InstanceFailure.assert!(cls, obj, opts)
    end
    alias_method :assert_not_instance_of, :refute_instance_of
  end


  module Matchers
    #
    #
    #   object.assert is_an_instance_of(class)
    #
    def is_an_instance_of(cls)
      InstanceFailure.to_matcher(regexp)
    end

    #
    #
    #   object.should be_an_instance_of(class)
    #
    def be_an_instance_of(cls)
      InstanceFailure.to_matcher(cls)
    end
  end

end
