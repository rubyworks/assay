module Assay

  module Nomenclature

    # Matchers provide a set of RSpec-compatible matcher methods. These 
    # matchers provide all the traditional Rspec matchers, less some
    # extraneous verbosity, plus additional matchers.
    #
    module Matchers

      #
      def self.activate
        ::Object.__send__(:include, self)
      end

    # CompareFailure

      # Passes if the expected and actual are alike.
      #
      #   object.should be_like(criterion)
      #
      def be_like(exp)
        CompareFailure.to_matcher(exp)
      end

      # Passes if the expected and actual are alike.
      #
      #   object.assert is_like(criterion)
      #
      alias_method :is_like, :be_like

    # DeltaFailure

      # Passes if expected and actual are equal within delta tolerance.
      #
      #   value1.should be_within(delta, value2)
      #
      def is_within(delta, exp)
        DeltaFailure.to_matcher(exp, delta)
      end

      # Passes if expected and actual are nto equal within delta tolerance.
      #
      #   value1.assert is_within(delta, value2)
      #
      def be_within(delta, exp)
        DeltaFailure.to_matcher(exp, delta)
      end

    # EmptyFailure

      # Passes if object is empty.
      #
      #   object.assert is_empty
      #
      def is_empty
        EmptyFailure.to_matcher
      end

      # Passes if object is empty.
      #
      #   object.should be_empty
      #
      def be_empty
        EmptyFailure.to_matcher
      end

    # EqualityFailure

      # Passes if +expected+ == +actual+.
      #
      #   'MY STRING'.assert is_equal_to('my string'.upcase)
      #   'MY STRING'.refute is_equal_to('another string')
      #
      def is_equal_to(exp) #, opts={})
        EqualityFailure.to_matcher(exp)
      end

      # Passes if +expected+ == +actual+.
      #
      #   'MY STRING'.should be_equal_to('my string'.upcase)
      #   'MY STRING'.should_not be_equal_to('another string')
      #
      def be_equal_to(exp)
        EqualityFailure.to_matcher(exp)
      end

    # ExecutionFailure

      # FIXME: Reasonable matcher for ExectuionFailure ?
      #
      #
      #   proc.assert is_executed(*args)
      #
      def is_executed(*args, &block)
        ExecutionFailure.to_matcher(args, &block)
      end

      #
      #
      #   proc.should be_executed(*args)
      #
      def be_extecuted(&block)
        ExecutionFailure.to_matcher(args, &block)
      end

    # FalseFailure

      # Passed if object is +false+.
      #
      #   value.assert is_false
      #
      def is_false
        FalseFailure.to_matcher
      end

      # Passed if object is +false+.
      #
      #   value.should be_false
      #
      def be_false
        FalseFailure.to_matcher
      end

    # IdentityFailure

      # Passes if actual is the same exact object as expected.
      #
      #   object.assert is_identical_to(object)
      #
      def is_identical_to(obj)
        IdentityFailure.to_matcher(obj)
      end

      # Passes if actual is the same exact object as expected.
      #
      #   object.should be_identical_to(object)
      #
      def be_identical_to(obj)
        IdentityFailure.to_matcher(obj)
      end

    # InstanceFailure

      # Passes if object is an instance of class.
      #
      #   object.assert is_instance_of(class)
      #
      def is_instance_of(cls)
        InstanceFailure.to_matcher(cls)
      end

      # Passes if object is an instance of class.
      #
      #   object.should be_instance_of(class)
      #
      def be_instance_of(cls)
        InstanceFailure.to_matcher(cls)
      end

    # KindFailure

      # Passes if object is a kind of class.
      #
      #   object.assert is_a_kind_of(class)
      #
      def is_kind_of(cls)
        KindFailure.to_matcher(cls) 
      end

      # Passes if object is a kind of class.
      #
      #   object.should be_a_kind_of(class)
      #
      def be_kind_of(cls)
        KindFailure.to_matcher(cls)
      end

    # MatchFailure

      # Passes if object matches pattern using `#=~` method.
      #
      #   object.assert is_match_for(regexp)
      #
      def is_match_for(regexp)
        MatchFailure.to_matcher(regexp)
      end

      # Passes if object matches pattern using `#=~` method.
      #
      #   object.should be_match_for(regexp)
      #
      def be_match_for(regexp)
        MatchFailure.to_matcher(regexp)
      end

    # NilFailure

      # Passed if object is +nil+.
      #
      #   value.assert is_nil
      #
      def is_nil
        NilFailure.to_matcher
      end

      # Passed if object is +nil+.
      #
      #   value.should be_nil
      #
      def be_nil
        NilFailure.to_matcher
      end

    # RaiseFailure

      # FIXME: Fix raise matchers
      #
      #   Exception.assert is_raised{ ... }
      #
      def is_raised(&blk)
        RaiseFailure.to_matcher(&blk)
      end

      #
      #
      #   Exception.should be_raised{ ... }
      #
      def be_raised(&blk)
        RaiseFailure.to_matcher(&blk)
      end

    # RespondFailure

      #
      #
      #   object.assert is_responsive_to(:method_symbol)
      #
      def is_responsive_to(method)
        ResponseFailure.to_matcher(method)
      end

      #
      #
      #   object.should be_responsive_to(:method_symbol)
      #
      def be_responsive_to(method)
        ResponseFailure.to_matcher(method)
      end

    # SameFailure

      #
      #
      #   object1.assert is_same_as(object2)
      #
      def is_same_as(obj)
        SameFailure.to_matcher(obj)
      end

      #
      #
      #   object1.should be_same_as(object2)
      #
      def be_same_as(obj)
        SameFailure.to_matcher(obj)
      end

    # ThrowFailure

      #
      #
      #   :symbol.assert is_thrown{ ... }
      #
      def is_thrown(&blk)
        ThrowFailure.to_matcher(&blk)
      end

      #
      #
      #   :symbol.should be_thrown{ ... }
      #
      def be_thrown(&blk)
        ThrowFailure.to_matcher(&blk)
      end

    # TrueFailure

      # Passed if object is +true+.
      #
      #   value.assert is_true
      #
      def is_true
        TrueFailure.to_matcher
      end

      # Passed if object is +true+.
      #
      #   value.should be_true
      #
      def be_true
        TrueFailure.to_matcher
      end

    end

  end

end
