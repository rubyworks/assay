require 'assay/assertions/compare_failure'

module Assay

  # Comparison assertion for #kind_of?
  #
  #   KindFailure.pass?(1, Integer)  #=> true
  #   KindFailure.fail?(1, String)   #=> true
  #
  class KindFailure < CompareFailure

    def self.assertion_name
      :kind_of
    end

    def self.assertion_operator
      :kind_of?
    end

    # Check assertion.
    def self.pass?(exp, act)
      exp.kind_of? act
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect
      act = @arguments[1].inspect

      if @_negated
        "Expected #{act} to be kind of #{exp}"
      else
        "Expected #{act} to be kind of #{exp}"
      end
    end
  end


  module Assertives
    # Passes if object .kind_of? klass
    #
    #   assert_kind_of(Object, 'foo')
    #
    def assert_kind_of(cls, obj, msg=nil)
      KindFailure.assert(cls, obj, :message=>msg, :backtrace=>caller)
    end

    # Passes if object .kind_of? klass
    #
    #   assert_not_kind_of(Object, 'foo')
    #
    def refute_kind_of(cls, obj, msg=nil)
      KindFailure.refute(cls, obj, :message=>msg, :backtrace=>caller)
    end
    alias_method :assert_not_kind_of, :refute_kind_of
  end


  module Matchers
    #
    #
    #   object.assert is_a_kind_of(class)
    #
    def is_kind_of(cls)
      KindFailure.to_matcher(cls) 
    end

    #
    #
    #   object.should be_a_kind_of(class)
    #
    def be_kind_of(cls)
      KindFailure.to_matcher(cls)
    end
  end

end
