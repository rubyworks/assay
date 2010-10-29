require 'assay/failure'
require 'assay/compare_failure'

module Assay

  #
  class KindFailure < CompareFailure

    def self.assertion_name
      :kind_of
    end

    def self.assertion_operator
      :kind_of?
    end

    def self.fail_message(exp, act)
      "Expected #{act.inspect} to be kind of #{exp.inspect}"
    end

    def self.fail_message!(exp, act)
      "Expected #{act.inspect} to be kind of #{exp.inspect}"
    end

    def self.check(exp, act)
      exp.kind_of? act
    end

    def self.check!(exp, act)
      ! exp.kind_of? act
    end

  end


  module Assertable
    # Passes if object .kind_of? klass
    #
    #   assert_kind_of(Object, 'foo')
    #
    def assert_kind_of(cls, obj, opts={})
      opts[:backtrace] ||= caller
      KindFailure.assert(cls, obj, opts)
    end

    # Passes if object .kind_of? klass
    #
    #   assert_not_kind_of(Object, 'foo')
    #
    def refute_kind_of(cls, obj, opts={})
      KindFailure.assert!(cls, obj, opts)
    end
    alias_method :assert_not_kind_of, :refute_kind_of
  end


  module Matchers
    #
    #
    #   object.assert is_a_kind_of(class)
    #
    def is_a_kind_of?(cls)
      KindFailure.to_matcher(cls) 
    end

    #
    #
    #   object.should be_a_kind_of(class)
    #
    def be_a_kind_of?(cls)
      KindFailure.to_matcher(cls)
    end
  end

end
