module Assay

  module Nomenclature

    # MiniMust assertion nomenclature is compatible with MiniTest's
    # "minispec" Expectaion methods.
    #
    module MustObjectives

      #
      def self.activate
        ::Object.__send__(:include, self)
      end

    # CompareFailure

      # Passes if object is like criterion.
      #
      #   object.must_be_like(criterion)
      #
      # See {CompareFailure}.
      #
      def must_be_like(exp)
        CompareFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not like criterion using {CompareFailure}.
      #
      #   object.wont_be_like(criterion)
      #
      # See {CompareFailure}.
      #
      def wont_be_like(act)
        CompareFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

    # DeltaFailure

      # Passes if expected and actual are equal within delta tolerance.
      #
      #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
      #
      # See {DeltaFailure}.
      #
      def must_be_within_delta(exp, delta, msg=nil)
        DeltaFailure.assert(self, exp, delta, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected and actual are equal not within delta tolerance.
      #
      #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
      #
      # See {DeltaFailure}.
      #
      def wont_be_within_delta(exp, delta, msg=nil)
        DeltaFailure.refute(self, exp, delta, :message=>msg, :backtrace=>caller)
      end

    # EmptyFailure

      # Passes if object is empty.
      #
      #   object.must_be_empty
      #
      def must_be_empty
        EmptyFailure.assert(self, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not empty.
      #
      #   object.wont_be_empty
      #
      def wont_be_empty
        EmptyFailure.refute(self, :message=>msg, :backtrace=>caller)
      end

    # EqualityFailure

      # Passes if expected == +actual.
      #
      # Note that the ordering of arguments is important,
      # since a helpful error message is generated when this
      # one fails that tells you the values of expected and actual.
      #
      #   'MY STRING'.must_equal('my string'.upcase)
      #
      def must_equal(exp, msg=nil)
        EqualityFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected != actual
      #
      #  'some string'.wont_equal('some other string')
      #
      def assert_not_equal(exp, msg=nil)
         EqualityFailure.refute(self, :message=>msg, :backtrace=>caller)
      end

    # ExecutionFailure

      # Passes if the block yields successfully.
      #
      #   proc.must_execute("Couldn't do the thing")
      #
      def must_execute(msg=nil)
        ExecutionFailure.assert(:message=>msg, :backtrace=>caller, &self)
      end

      # Passes if the block does not yield successfully.
      #
      # refute_executes "Couldn't do the thing" do
      #   do_the_thing
      # end
      #
      def wont_execute(msg=nil, &blk)
        ExecutionFailure.refute(:message=>msg, :backtrace=>caller, &self)
      end

    # FalseFailure

      # Passed if object is +false+.
      #
      def must_be_false(exp, msg=nil)
        FalseFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +false+.
      #
      #   assert_not_false(false)
      #
      def wont_be_false(exp, msg=nil)
        FalseFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    # IdentityFailure

      # Passes if actual is the same exact object as expected.
      #
      #   object.must_be_identical_to(object)
      #
      def must_be_identical_to(exp)
        IdentityFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if actual is not the same exact object as expected.
      #
      #   object.wont_be_identical_to(other)
      #
      def wont_be_identical_to(exp)
        IdentityFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

    # InstanceFailure

      # Passes if object is an instance of class.
      #
      #   'foo'.must_be_instance_of(String)
      #
      def must_be_instance_of(cls, msg=nil)
        InstanceFailure.assert(self, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not an instance of class.
      #
      #   'foo'.wont_be_instance_of(Integer)
      #
      def wont_be_instance_of(cls, msg=nil)
        InstanceFailure.refute(self, cls, :message=>msg, :backtrace=>caller)
      end

    # KindFailure

      # Passes if object is a kind of class.
      #
      #   assert_kind_of(Object, 'foo')
      #
      def must_be_kind_of(cls, msg=nil)
        KindFailure.assert(self, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not a kind of class.
      #
      #   assert_not_kind_of(Object, 'foo')
      #
      def wont_be_kind_of(cls, msg=nil)
        KindFailure.refute(self, cls, :message=>msg, :backtrace=>caller)
      end

    # MatchFailure

      # Passes if object matches pattern using `#=~` method.
      #
      #   'one 2 three'.must_match(/two/)
      #
      def must_match(exp, msg=nil)
        MatchFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object does not match pattern using `#=~` method.
      #
      #   'one 2 three'.wont_match(/two/)
      #
      def wont_match(exp, msg=nil)
        MatchFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

    # NilFailure

      # Passed if object is +nil+.
      #
      def must_be_nil(exp, msg=nil)
        NilFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +nil+.
      #
      #   assert_not_nil(true)
      #
      def wont_be_nil(exp, msg=nil)
        NilFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    # RaiseFailure

      # Passes if the procedure raises a given exception.
      #
      #   lambda{ raise 'Boom!!!' }.must_raise(RuntimeError)
      #
      def must_raise(exp, msg=nil, call=nil)
        RaiseFailure.assert(exp, msg=nil, call=nil, &self)
      end

      # Passes if the procedure *does not* raise a given exceptions.
      #
      #   lambda{ raise 'Boom!!!' }.wont_raise(IOError)
      #
      def wont_raise(exp, msg=nil, call=nil) #:yeild:
        RaiseFailure.refute(exp, msg, call, &self)
      end

    # ResponseFailure

      # Passes if +object+ respond_to? +methods+.
      #
      #   'bugbear'.must_respond_to(:slice)
      #
      def must_respond_to(method, msg=nil)
        ResponseFailure.assert(self, method, :message=>msg, :backtrace=>caller)
      end
      alias_method :assert_responds_to, :assert_respond_to

      # Passes if +object+ does not respond_to? +methods+.
      #
      #   'bugbear'.wont_respond_to(:slice)
      #
      def wont_respond_to(method, msg=nil)
        ResponseFailure.refute(self, method, :message=>msg, :backtrace=>caller)
      end

    # SameFailure

      # Passes if +expected+ .eql? +actual+.
      #
      # Note that the ordering of arguments is important,
      # since a helpful error message is generated when this
      # one fails that tells you the values of expected and actual.
      #
      #   'MY STRING'.must_be_same_as('my string'.upcase)
      #
      def must_be_same_as(exp, msg=nil)
        SameFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :must_eql, :must_be_same_as

      # Passes if not +expected+ .eql? +actual+.
      #
      #   'MY STRING'.wont_be_same_as('some other string')
      #
      def wont_be_same_as(exp, msg=nil)
        SameFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :wont_eql, :wont_be_same_as

    # ThrowFailure

      # Passes if the block throws expected_symbol
      #
      #   assert_throws :done do
      #     throw :done
      #   end
      #
      def must_throw(sym, msg=nil)
        ThrowFailure.assert(sym, :message=>msg, :backtrace=>caller, &self)
      end

      # Passes if the block throws expected_symbol
      #
      #   refute_throws :done do
      #     throw :chimp
      #   end
      #
      def wont_throw(sym, msg=nil)
        ThrowFailure.refute(sym, :message=>msg, :backtrace=>caller, &self)
      end

    # TrueFailure

      # Passed if object is +true+.
      #
      #   object.must_be_true
      #
      def must_be_true(exp, msg=nil)
        TrueFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +true+.
      #
      #   object.wont_be_true
      #
      def wont_be_true(exp, msg=nil)
        TrueFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    end

  end

end
