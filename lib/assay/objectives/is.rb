module Assay

  module Nomenclature

    # IsObjectives are like MustObjectives, but use `is`as method prefix instead
    # of `must`. It also removes extraneous `of`, `to`, `for` and `as` suffixes.
    # A few methods use `does` prefix instead, when it more natural to do so.
    #
    module IsObjectives

      #
      def self.activate
        ::Object.__send__(:include, self)
      end

    # CompareFailure

      # Passes if object is like criterion.
      #
      #   object.is_like(criterion)
      #
      # See {CompareFailure}.
      #
      def is_like(exp)
        CompareFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not like criterion using {CompareFailure}.
      #
      #   object.is_unlike(criterion)
      #
      # See {CompareFailure}.
      #
      def is_not_like(exp)
        CompareFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :is_unlike, :is_not_like

    # DeltaFailure

      # Passes if expected and actual are equal within delta tolerance.
      #
      #   (50000.0 / 10**6).is_within(0.00001, 0.05)
      #
      # See {DeltaFailure}.
      #
      def is_within(delta, exp, msg=nil)
        DeltaFailure.assert(self, exp, delta, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected and actual are equal not within delta tolerance.
      #
      #   (50000.0 / 10**6).is_not_within!(0.00001, 0.05)
      #
      # See {DeltaFailure}.
      #
      def is_not_within!(delta, exp, msg=nil)
        DeltaFailure.refute(self, exp, delta, :message=>msg, :backtrace=>caller)
      end

    # EmptyFailure

      # Passes if object is empty.
      #
      #   object.is_empty
      #
      def is_empty
        EmptyFailure.assert(self, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not empty.
      #
      #   object.is_not_empty
      #
      def is_not_empty
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
      def is_equal(exp, msg=nil)
        EqualityFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if expected != actual
      #
      #  'some string'.is_unequal('some other string')
      #
      def is_not_equal(exp, msg=nil)
         EqualityFailure.refute(self, :message=>msg, :backtrace=>caller)
      end

      alias_method :is_unequal, :is_not_equal

    # ExecutionFailure

      # Passes if the block yields successfully.
      #
      #   proc.is_executable("Couldn't do the thing")
      #
      def is_executable(msg=nil)
        ExecutionFailure.assert(:message=>msg, :backtrace=>caller, &self)
      end

      # Passes if the block does not yield successfully.
      #
      #   proc.is_not_executable("Couldn't do the thing")
      #
      def is_not_executable(msg=nil, &blk)
        ExecutionFailure.refute(:message=>msg, :backtrace=>caller, &self)
      end

    # FalseFailure

      # Passed if object is +false+.
      #
      def is_false(exp, msg=nil)
        FalseFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +false+.
      #
      #   assert_not_false(false)
      #
      def is_not_false(exp, msg=nil)
        FalseFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    # IdentityFailure

      # Passes if actual is the same exact object as expected.
      #
      #   object.is_identical(object)
      #
      def is_identical(exp)
        IdentityFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if actual is not the same exact object as expected.
      #
      #   object.is_not_identical(other)
      #
      def is_not_identical(exp)
        IdentityFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

    # InstanceFailure

      # Passes if object is an instance of class.
      #
      #   'foo'.is_instance_of(String)
      #
      def is_instance_of(cls, msg=nil)
        InstanceFailure.assert(self, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not an instance of class.
      #
      #   'foo'.is_not_instance_of(Integer)
      #
      def is_not_instance_of(cls, msg=nil)
        InstanceFailure.refute(self, cls, :message=>msg, :backtrace=>caller)
      end

    # KindFailure

      # Passes if object is a kind of class.
      #
      #   object.is_kind(Object)
      #
      def is_kind(cls, msg=nil)
        KindFailure.assert(self, cls, :message=>msg, :backtrace=>caller)
      end

      # Passes if object is not a kind of class.
      #
      #   object.is_not_kind(Object)
      #
      def is_not_kind(cls, msg=nil)
        KindFailure.refute(self, cls, :message=>msg, :backtrace=>caller)
      end

    # MatchFailure

      # Passes if object matches pattern using `#=~` method.
      #
      #   'one 2 three'.is_match(/two/)
      #
      def is_match(exp, msg=nil)
        MatchFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      # Passes if object does not match pattern using `#=~` method.
      #
      #   'one 2 three'.is_not_match(/two/)
      #
      def is_not_match(exp, msg=nil)
        MatchFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

    # NilFailure

      # Passed if object is +nil+.
      #
      #   object.is_nil
      #
      def is_nil(exp, msg=nil)
        NilFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +nil+.
      #
      #   object.is_not_nil
      #
      def is_not_nil(exp, msg=nil)
        NilFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    # RaiseFailure

      # Passes if the procedure raises a given exception.
      #
      #   RuntimeError.is_raised{ raise 'Boom!!!' }
      #
      def does_raise(exp, msg=nil, call=nil)
        RaiseFailure.assert(exp, msg=nil, call=nil, &self)
      end

      # Passes if the procedure *does not* raise a given exceptions.
      #
      #   IOError.is_not_raised{ raise 'Boom!!!' }
      #
      def does_not_raise(exp, msg=nil, call=nil)
        RaiseFailure.refute(exp, msg, call, &self)
      end

      # Passes if the procedure raises a given exception.
      #
      #   lambda{ raise 'Boom!!!' }.does_raise(RuntimeError)
      #
      def is_raised(exp, msg=nil, call=nil, &blk)
        RaiseFailure.assert(exp, msg=nil, call=nil, &blk)
      end

      # Passes if the procedure *does not* raise a given exceptions.
      #
      #   lambda{ raise 'Boom!!!' }.does_not_raise(IOError)
      #
      def is_not_raised(exp, msg=nil, call=nil, &blk)
        RaiseFailure.refute(exp, msg, call, &blk)
      end

    # ResponseFailure

      # Passes if +object+ respond_to? +methods+.
      #
      #   'bugbear'.does_respond(:slice)
      #
      def does_respond(method, msg=nil)
        ResponseFailure.assert(self, method, :message=>msg, :backtrace=>caller)
      end

      # Passes if +object+ does not respond_to? +methods+.
      #
      #   'bugbear'.does_not_respond(:slice)
      #
      def does_not_respond(method, msg=nil)
        ResponseFailure.refute(self, method, :message=>msg, :backtrace=>caller)
      end

    # SameFailure

      # Passes if +expected+ .eql? +actual+.
      #
      # Note that the ordering of arguments is important,
      # since a helpful error message is generated when this
      # one fails that tells you the values of expected and actual.
      #
      #   'MY STRING'.is_same('my string'.upcase)
      #
      def is_same(exp, msg=nil)
        SameFailure.assert(self, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :is_eql, :is_not_same

      # Passes if not +expected+ .eql? +actual+.
      #
      #   'MY STRING'.is_not_same('some other string')
      #
      def is_not_same(exp, msg=nil)
        SameFailure.refute(self, exp, :message=>msg, :backtrace=>caller)
      end

      alias_method :is_not_eql, :is_not_same

    # ThrowFailure

      # Passes if the block throws expected_symbol
      #
      #   :done.is_thrown do
      #     throw :done
      #   end
      #
      def is_thrown(sym, msg=nil, &blk)
        ThrowFailure.assert(sym, :message=>msg, :backtrace=>caller, &blk)
      end

      # Passes if the block throws expected_symbol
      #
      #   :done.is_not_thrown do
      #     throw :undone
      #   end
      #
      def is_not_thrown(sym, msg=nil, &blk)
        ThrowFailure.refute(sym, :message=>msg, :backtrace=>caller, &blk)
      end

    # TrueFailure

      # Passed if object is +true+.
      #
      #   object.is_true
      #
      def is_true(exp, msg=nil)
        TrueFailure.assert(exp, :message=>msg, :backtrace=>caller)
      end

      # Passed if object is not +true+.
      #
      #   object.is_not_true
      #
      def is_not_true(exp, msg=nil)
        TrueFailure.refute(exp, :message=>msg, :backtrace=>caller)
      end

    end

  end

end
