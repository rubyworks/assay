require 'assay/compare_failure'

module Assay

  class InstanceFailure < CompareFailure

    def self.assertion_name
      :instance
    end

    def self.assertion_operator
      :instance_of?
    end

    # Check assertion.
    def self.check(exp, act)
      exp.instance_of?(act)
    end

    # Check negated assertion.
    def self.check!(exp, act)
      ! exp.instance_of?(act)
    end

    #
    def to_s
      return super unless @_arguments.size == 2

      exp = @_arguments[0].inspect
      act = @_arguments[1].inspect

      if @_negated
        "Expected #{act} to NOT be an instance of #{exp}"  
        else
        "Expected #{act} to be an instance of #{exp}"
      end
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
    def is_instance_of(cls)
      InstanceFailure.to_matcher(cls)
    end

    #
    #
    #   object.should be_an_instance_of(class)
    #
    def be_instance_of(cls)
      InstanceFailure.to_matcher(cls)
    end
  end

end
