module Assay

  module Nomenclature

    # LegacyAssertions provided assertion methods which are compatable with
    # the the traditional TestUnit and MiniTest assertion methods.
    #
    # NOTE: There may stil be a few descrepencies yet to work out for full compatabilty.
    #
    module LegacyAssertions

      #
      def self.activate
        ::Object.__send__(:include, self)
      end

    # CompareFailure

      #
      #
      #   assert_alike(criteron, object)
      #
      def assert_alike(exp, act, msg=nil)
        CompareFailure.assert(act, exp, :message=>msg, :backtrace=>caller)
      end

      #
      #
      #   refute_alike(criteron, object)
      #
      def refute_alike(exp, act, msg=nil)
        CompareFailure.refute(act, exp, :message=>msg, :backtrace=>caller)
      end

    # DeltaFailures

      # Passes if expected and actual are equal within delta tolerance.
      #
      #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
      #
      def assert_in_delta(exp, act, delta, msg=nil)
        DeltaFailure.assert(act, exp, delta, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected and actual are equal not within delta tolerance.
      #
      #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
      #
      def refute_in_delta(exp, act, delta, msg=nil)
        #opts[:backtrace] ||= caller
        DeltaFailure.refute(act, exp, delta, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_within_delta, :refute_within_delta

    # EmptyFailure

      # Passes if object is empty.
      #
      #   assert_empty(object)
      #
      def assert_empty(exp, msg=nil)
        EmptyFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not empty.
      #
      #   refute_empty(object)
      #
      def refute_empty(exp, msg=nil)
        #opts[:backtrace] ||= caller
        EmptyFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_empty, :refute_empty

    # EqualityFailure

      # Passes if expected == +actual.
      #
      # Note that the ordering of arguments is important,
      # since a helpful error message is generated when this
      # one fails that tells you the values of expected and actual.
      #
      #   assert_equal 'MY STRING', 'my string'.upcase
      #
      def assert_equal(exp, act, msg=nil)
        EqualityFailure.assert(act, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected != actual
      #
      #  assert_not_equal 'some string', 5
      #
      def assert_not_equal(exp, act, msg=nil)
         EqualityFailure.refute(act, exp, :message=>msg, :backtrace=>caller)
      end

    # ExecutionFailure

      # Passes if the block yields successfully.
      #
      #   assert_executes "Couldn't do the thing" do
      #     do_the_thing
      #   end
      #
      def assert_executes(msg=nil, &blk)
        ExecutionFailure.assert(:message=>msg, :backtrace=>caller, &prco)
      end

      # Passes if the block does not yield successfully.
      #
      #   refute_executes "Couldn't do the thing" do
      #     do_the_thing
      #   end
      #
      def refute_executes(msg=nil, &proc)
        ExecutionFailure.refute(:message=>msg, :backtrace=>caller, &proc)
      end

    # FalseFailure

      # Passed if object is +false+.
      #
      def assert_false(exp, msg=nil)
        FalseFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +false+.
      #
      #  refute_false(false)
      #
      def refute_false(exp, msg=nil)
        FalseFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_false, :refute_false

    # IdentityFailure

      # Passes if actual is the same exact object as expected.
      #
      #   assert_identical(object, object)
      #
      def assert_identical(exp, act, msg=nil)
        IdentityFailure.assert(act, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if actual is not the same exact object as expected.
      #
      #   refute_identical(object, other)
      #
      def refute_identical(exp, act, msg=nil)
        IdentityFailure.refute(act, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_identical, :refute_identical

    # InstanceFailure

      # Passes if object is an instance of class.
      #
      #   assert_instance_of(String, 'foo')
      #
      def assert_instance_of(cls, obj, msg=nil)
        InstanceFailure.assert(obj, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not an instance of class.
      #
      #   assert_instance_of(String, 'foo')
      #
      def refute_instance_of(cls, obj, msg=nil)
        InstanceFailure.refute(obj, cls, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_instance_of, :refute_instance_of

    # KindFailure

      # Passes if object .kind_of? klass
      #
      #   assert_kind_of(Object, 'foo')
      #
      def assert_kind_of(cls, obj, msg=nil)
        KindFailure.assert(obj, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object .kind_of? klass
      #
      #   assert_not_kind_of(Object, 'foo')
      #
      def refute_kind_of(cls, obj, msg=nil)
        KindFailure.refute(obj, cls, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_kind_of, :refute_kind_of

    # MatchFailure

      # Passes if object matches pattern using `#=~` method.
      #
      #   assert_match(/\d+/, 'five, 6, seven')
      #
      def assert_match(exp, act, msg=nil)
        MatchFailure.assert(act, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object does not match pattern using `#=~` method.
      #
      #   refute_match(/two/, 'one 2 three')
      #
      def refute_match(exp, act, msg=nil)
        MatchFailure.refute(act, exp, :message=>msg, :backtrace=>caller)
      end

    # NilFailure

      # Passed if object is +nil+.
      #
      #   assert_nil(nil)
      #
      def assert_nil(exp, msg=nil)
        NilFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +nil+.
      #
      #   refute_nil(true)
      #
      def refute_nil(exp, msg=nil)
        #opts[:backtrace] ||= caller
        NilFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_nil, :refute_nil

    # RaiseFailure

      # Passes if the block raises a given exception.
      #
      #   assert_raises RuntimeError do
      #     raise 'Boom!!!'
      #   end
      #
      def assert_raises(exp, msg=nil, call=nil, &blk) #:yeild:
        RaiseFailure.assert(exp, msg=nil, call=nil, &blk)
      end

      # Passes if the block *does not* raise a given exceptions.
      #
      #   assert_not_raised IOError do
      #     raise 'Boom!!!'
      #   end
      #
      def assert_not_raised(exp, msg=nil, call=nil, &blk) #:yeild:
        RaiseFailure.refute(exp, msg, call, &blk)
      end

    # ResponseFailure

      # Passes if +object+ respond_to? +methods+.
      #
      #   assert_respond_to 'bugbear', :slice
      #
      def assert_respond_to(reciever, method, msg=nil)
        ResponseFailure.assert(reciever, method, :message=>msg, :backtrace=>caller)
      end
      alias_method :assert_responds_to, :assert_respond_to

      # Passes if +object+ does not respond_to? +methods+.
      #
      #   assert_not_respond_to 'bugbear', :slice
      #
      def assert_not_respond_to(reciever, method, msg=nil)
        ResponseFailure.refute(reciever, method, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_responds_to, :assert_not_respond_to

    # SameFailure

      # Passes if +expected+ .eq? +actual+.
      #
      # Note that the ordering of arguments is important,
      # since a helpful error message is generated when this
      # one fails that tells you the values of expected and actual.
      #
      #   assert_same 'MY STRING', 'my string'.upcase
      #
      def assert_same(exp, act, msg=nil)
        SameFailure.assert(exp, act, :message=>msg, :backtrace=>caller)
      end

      # Passes if not +expected+ .eq? +actual+.
      #
      #  assert_not_the_same 'some string', 5
      #
      def refute_same(exp, act, msg=nil)
        SameFailure.refute(exp, act, :message=>msg, :backtrace=>caller)
      end

      alias_method :assert_not_same, :refute_same

    # ThrowFailure

      # Passes if the block throws expected_symbol
      #
      #   assert_throws :done do
      #     throw :done
      #   end
      #
      def assert_throws(sym, msg=nil, &blk)
        ThrowFailure.assert(sym, :message=>msg, :backtrace=>caller, &blk)
      end

      # Passes if the block throws expected_symbol
      #
      #   refute_throws :done do
      #     throw :chimp
      #   end
      #
      def refute_throws(sym, msg=nil, &blk)
        ThrowFailure.refute(sym, :message=>msg, :backtrace=>caller, &blk)
      end

      alias_method :assert_not_thrown, :refute_throws

    # TrueFailure

      # Passed if object is +true+.
      #
      def assert_true(exp, msg=nil)
        TrueFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +true+.
      #
      #   assert_not_true(false)
      #
      def assert_not_true(exp, msg=nil)
        TrueFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    end

  end

end
