module Assay; end
module Assay::MiniTest

  # This module provides extensions for MiniTest compatiblity.
  #
  # The set is not fully compataible, but provides most of MiniTest
  # extensions.
  #
  # Compatability will improve with time.
  #
  module Extensions

    # Passes it operator with optional argument returns successfully.
    #
    #   10.must_be :>, 4
    #   10.must_be :even?
    #
    # @raise ExecutionAssay
    #
    def must_be(operator, argument=nil, msg=nil)
      if argument
        ExecutionAssay.assert!(:message=>msg) do
          __send__(operator, argument)
        end
      else
        ExecutionAssay.assert!(:message=>msg) do
          __send__(operator)
        end
      end
    end

    #
    # Passes it operator with optional argument returns negatively.
    #
    #   10.wont_be :>, 20
    #   10.wont_be :odd?
    #
    # @raise ExecutionAssay
    #
    def wont_be(operator, argument=nil, msg=nil)
      if argument
        ExecutionAssay.refute!(:message=>msg) do
          self.__send__(operator, argument)
        end
      else
        ExecutionAssay.refute!(:message=>msg) do
          self.__send__(operator)
        end
      end
    end
  
    #
    # Passes if object is like criterion.
    #
    #   object.must_be_like(criterion)
    #
    # @raise LikeAssay
    #
    def must_be_like(exp, msg=nil)
      LikeAssay.assert!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not like criterion using {CompareAssay}.
    #
    #   object.wont_be_like(criterion)
    #
    # @raise LikeAssay
    #
    def wont_be_like(exp, msg=nil)
      LikeAssay.refute!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are equal within absolute delta tolerance.
    #
    #   0.05.must_be_within_delta (50000.0 / 10**6), 0.00001
    #
    # @raise WithinAssay
    #
    def must_be_within_delta(exp, delta, msg=nil)
      WithinAssay.assert!(self, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are NOT equal within absolute delta tolerance.
    #
    #   0.05.wont_be_within_delta (50000.0 / 10**6), 0.00001
    #
    # @raise WithinAssay
    #
    def wont_be_within_delta(exp, delta, msg=nil)
      WithinAssay.refute!(self, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are equal within relative epsilon tolerance.
    #
    #   0.05.must_be_within_epsilon (50000.0 / 10**6), 0.00001
    #
    # @raise CloseAssay
    #
    def must_be_within_epsilon(exp, epsilon, msg=nil)
      CloseAssay.assert!(self, exp, epsilon, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are NOT equal within relative epsilon tolerance.
    #
    #   0.05.wont_be_within_epsilon (50000.0 / 10**6), 0.00001
    #
    # @raise CloseAssay
    #
    def wont_be_within_epsilon(exp, epsilon, msg=nil)
      WithinAssay.refute!(self, exp, epsilon, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is empty.
    #
    #   object.must_be_empty
    #
    # @raise EmptyAssay
    #
    def must_be_empty(msg=nil)
      EmptyAssay.assert!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not empty.
    #
    #   object.wont_be_empty
    #
    # @raise EmptyAssay
    #
    def wont_be_empty(msg=nil)
      EmptyAssay.refute!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected == +actual.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   'MY STRING'.must_equal('my string'.upcase)
    #
    # @raise EqualAssay
    #
    def must_equal(exp, msg=nil)
      EqualAssay.assert!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected != actual
    #
    #  'some string'.wont_equal('some other string')
    #
    # @raise EqualAssay
    #
    def wont_equal(exp, msg=nil)
       EqualAssay.refute!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if method call returns successfully.
    #
    #   "string".must_send([:upcase], "Doesn't upcase!")
    #
    # @raise ExecutionAssay
    #
    def must_send(send_array, msg=nil)
      ExecutionAssay.assert!(:message=>msg, :backtrace=>caller) do
        self.__send__(*send_array)
      end
    end

    #
    # Passes if method call does not return successfully.
    #
    #   "string".wont_send([:upcase], "Damn you, Uppercase!")
    #
    # @raise ExecutionAssay
    #
    def wont_send(send_array, msg=nil)
      ExecutionAssay.refute!(:message=>msg, :backtrace=>caller) do
        self.__send__(*send_array)
      end
    end

    #
    # Passes if the block yields successfully.
    #
    #   5.must_satisfy{ |x| x > 3 }
    #
    # @raise ExecutionAssay
    #
    def must_satisfy(msg=nil, &block)
      ExecutionAssay.assert!(self, :message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passes if the block does not yield successfully.
    #
    #   5.wont_satisfy{ |x| x < 3 }
    #
    # @raise ExecutionAssay
    #
    def wont_satisfy(msg=nil, &block)
      ExecutionAssay.refute!(self, :message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passed if object is +false+.
    #
    # @raise FalseAssay
    #
    def must_be_false(msg=nil)
      FalseAssay.assert!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +false+.
    #
    #   assert_not_false(false)
    #
    # @raise FalseAssay
    #
    def wont_be_false(msg=nil)
      FalseAssay.refute!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `self` is the same exact object as expected.
    #
    #   object.must_be_same_as(object)
    #
    # @raise IdentityAssay
    #
    def must_be_same_as(exp, msg=nil)
      IdentityAssay.assert!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if actual is not the same exact object as expected.
    #
    #   object.wont_be_same_as(other)
    #
    # @raise IdentityAssay
    #
    def wont_be_same_as(exp, msg=nil)
      IdentityAssay.refute!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is an instance of class.
    #
    #   'foo'.must_be_instance_of(String)
    #
    # @raise InstanceAssay
    #
    def must_be_instance_of(cls, msg=nil)
      InstanceAssay.assert!(self, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not an instance of class.
    #
    #   'foo'.wont_be_instance_of(Integer)
    #
    # @raise InstanceAssay
    #
    def wont_be_instance_of(cls, msg=nil)
      InstanceAssay.refute!(self, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is a kind of class.
    #
    #   assert_kind_of(Object, 'foo')
    #
    # @raise KindAssay
    #
    def must_be_kind_of(cls, msg=nil)
      KindAssay.assert!(self, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not a kind of class.
    #
    #   assert_not_kind_of(Object, 'foo')
    #
    # @raise KindAssay
    #
    def wont_be_kind_of(cls, msg=nil)
      KindAssay.refute!(self, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object matches pattern using `#=~` method.
    #
    #   'one 2 three'.must_match(/two/)
    #
    # @raise MatchAssay
    #
    def must_match(exp, msg=nil)
      MatchAssay.assert!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object does not match pattern using `#=~` method.
    #
    #   'one 2 three'.wont_match(/two/)
    #
    # @raise MatchAssay
    #
    def wont_match(exp, msg=nil)
      MatchAssay.refute!(self, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is +nil+.
    #
    # @raise NilAssay
    #
    def must_be_nil(msg=nil)
      NilAssay.assert!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +nil+.
    #
    #   assert_not_nil(true)
    #
    # @raise NilAssay
    #
    def wont_be_nil(msg=nil)
      NilAssay.refute!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if the procedure raises a given exception.
    #
    #   lambda{ raise 'Boom!!!' }.must_raise(RuntimeError)
    #
    # @raise RaiseAssay
    #
    def must_raise(exp, msg=nil, call=nil)
      RaiseAssay.assert!(exp, msg=nil, call=nil, &self)
    end

    #
    # Passes if the procedure *does not* raise a given exceptions.
    #
    #   lambda{ raise 'Boom!!!' }.wont_raise(IOError)
    #
    # @raise RaiseAssay
    #
    def wont_raise(exp, msg=nil, call=nil)
      RaiseAssay.refute!(exp, msg, call, &self)
    end

    #
    # Passes if +object+ respond_to? +methods+.
    #
    #   'bugbear'.must_respond_to(:slice)
    #
    # @raise RespondAssay
    #
    def must_respond_to(method, msg=nil)
      RespondAssay.assert!(self, method, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if +object+ does not respond_to? +methods+.
    #
    #   'bugbear'.wont_respond_to(:slice)
    #
    # @raise RespondAssay
    #
    def wont_respond_to(method, msg=nil)
      RespondAssay.refute!(self, method, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `criterion.eql?(actual)`.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   'MY STRING'.must_be_equivalent_to('my string'.upcase)
    #
    # @raise EqualityAssay
    #
    def must_be_equivalent_to(criterion, msg=nil)
      EqualityAssay.assert!(self, criterion, :message=>msg, :backtrace=>caller)
    end

    alias_method :must_eql, :must_be_equivalent_to

    #
    # Passes if NOT `criterion.eql?(actual)`.
    #
    #   'MY STRING'.wont_be_equivalent_to('some other string')
    #
    # @raise EqualityAssay
    #
    def wont_be_equivalent_to(criterion, msg=nil)
      EqualityAssay.refute!(self, criterion, :message=>msg, :backtrace=>caller)
    end

    alias_method :wont_eql, :wont_be_equivalent_to

    #
    # Passes if the block throws expected_symbol
    #
    #   assert_throws :done do
    #     throw :done
    #   end
    #
    # @raise ThrowAssay
    #
    def must_throw(sym, msg=nil)
      ThrowAssay.assert!(sym, :message=>msg, :backtrace=>caller, &self)
    end

    #
    # Passes if the block throws expected_symbol
    #
    #   refute_throws :done do
    #     throw :chimp
    #   end
    #
    # @raise ThrowAssay
    #
    def wont_throw(sym, msg=nil)
      ThrowAssay.refute!(sym, :message=>msg, :backtrace=>caller, &self)
    end

    #
    # Passed if object is +true+.
    #
    #   object.must_be_true
    #
    # @raise TrueAssay
    #
    def must_be_true(msg=nil)
      TrueAssay.assert!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +true+.
    #
    #   object.wont_be_true
    #
    # @raise TrueAssay
    #
    def wont_be_true(msg=nil)
      TrueAssay.refute!(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `self.include?(object)`.
    #
    # @raise IncludeAssay
    #
    def must_include(object, msg=nil)
      IncludeAssay.assert!(self, object, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `self.include?(object)`.
    #
    # @raise IncludeAssay
    #
    def wont_include(object, msg=nil)
      IncludeAssay.refute!(self, object, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if output matches +pattern+.
    #
    # @example
    #   proc{ puts "fun!" }.must_output('fun!')
    #
    # @raise OutputAssay
    #
    def must_output(pattern, msg=nil)
      OutputAssay.assert!(pattern, :message=>msg, :backtrace=>caller, &self)
    end

  end

end
