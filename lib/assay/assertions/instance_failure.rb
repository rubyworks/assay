require 'assay/assertions/compare_failure'

module Assay

  class InstanceFailure < CompareFailure

    def self.assertion_name
      :instance
    end

    def self.assertion_operator
      :instance_of?
    end

    # Check assertion.
    def self.pass?(exp, act)
      exp.instance_of?(act)
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect
      act = @arguments[1].inspect

      if @_negated
        "Expected #{act} to NOT be an instance of #{exp}"  
        else
        "Expected #{act} to be an instance of #{exp}"
      end
    end
  end


  module Assertives
    # Passes if object .instance_of? klass
    #
    #   assert_instance_of(String, 'foo')
    #
    def assert_instance_of(cls, obj, msg=nil)
      InstanceFailure.assert(cls, obj, :message=>msg, :backtrace=>caller)
    end

    # Passes if object .instance_of? klass
    #
    #   assert_instance_of(String, 'foo')
    #
    def refute_instance_of(cls, obj, msg=nil)
      InstanceFailure.refute(cls, obj, :message=>msg, :backtrace=>caller)
    end

    alias_method :assert_not_instance_of, :refute_instance_of
  end


  module Matchers
    #
    #
    #   object.assert is_instance_of(class)
    #
    def is_instance_of(cls)
      InstanceFailure.to_matcher(cls)
    end

    #
    #
    #   object.should be_instance_of(class)
    #
    def be_instance_of(cls)
      InstanceFailure.to_matcher(cls)
    end
  end

end
