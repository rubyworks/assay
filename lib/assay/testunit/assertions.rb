module Assay; end
module Assay::TestUnit

  # This module holds the Test::Unit assertion methods for Test::Unit
  # compatibility.
  #
  # While it does not provide 100% of Test::Unit assertions at the moment,
  # compatibility will improved with upcoming releases.
  #
  # @see http://test-unit.rubyforge.org/test-unit/en/
  #
  # @todo Should we adjust error message to be like Test::Units ?
  #
  module Assertions

    #
    #def assert_alias_method(object, alias_name, original_name, message = nil)
    #end

    #
    # Passes if actual is like expected, where `like` means satisfyin any one 
    # of `#===`, `#==`, `#eql?` or `#equal?` calls.
    #
    # This is not strictly a Test::Unit assertion but is added here to cover
    # all of Assay's availabe assertion classes.
    #
    def assert_alike(exp, act, msg=nil)
      LikeAssay.assert!(act, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if actual is NOT like expected, where `like` means satisfyin any
    # one of `#===`, `#==`, `#eql?` or `#equal?` calls.
    #
    def assert_not_alike(exp, act, msg=nil)
      LikeAssay.refute!(act, exp, :message=>msg, :backtrace=>caller)
    end

    #
    #
    #
    def assert_block(message="assert_block failed.", &block)
      ExecutionAssay.assert!(:message=>message, &block)
    end

    #
    # Passes if `boolean` is either `true` or `false`.
    #
    def assert_boolean(boolean, message=nil)
      BooleanAssay.assert!(boolean, :message=>message)
    end

    #
    # Passes if `boolean` is not either `true` or `false`.
    #
    def assert_not_boolean(boolean, message=nil)
      BooleanAssay.refute!(boolean, :message=>message)
    end

    # Passes if `object` satisify compaision by `operator`.
    #
    def assert_compare(receiver, operator, operand, message=nil)
      case operator.to_sym
      when :<
        LessAssay.assert!(receiver, operand, :message=>message, :backtrace=>caller)
      when :<=
        LessEqualAssay.assert!(receiver, operand, :message=>message, :backtrace=>caller)
      when :>
        MoreAssay.assert!(receiver, operand, :message=>message, :backtrace=>caller)
      when :>=
        MoreEqualAssay.assert!(receiver, operand, :message=>message, :backtrace=>caller)
      when :==
        EqualAssay.assert!(operand, receiver, :message=>message, :backtrace=>caller)
      else
        raise ArgumentError, "comparision operator must be one of <, <=, >, >= or '=='"
      end
    end

    #
    #
    #
    #def assert_const_defined(object, constant_name, message=nil)
    #end

    #
    #
    #
    #def assert_not_const_defined(object, constant_name, message=nil)
    #end

    # Passes if object is empty.
    #
    #   assert_empty(object)
    #
    def assert_empty(exp, msg=nil)
      EmptyAssay.assert!(exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is not empty.
    #
    #   refute_empty(object)
    #
    def assert_not_empty(exp, msg=nil)
      EmptyAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected == +actual.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   assert_equal 'MY STRING', 'my string'.upcase
    #
    def assert_equal(exp, act, msg=nil)
      EqualAssay.assert!(act, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected != actual
    #
    #  assert_not_equal 'some string', 5
    #
    def assert_not_equal(exp, act, msg=nil)
       EqualAssay.refute!(act, exp, :message=>msg, :backtrace=>caller)
    end

    #
    #def assert_fail_assertion(message = nil) 
    #end

    #
    # Passed if object is +false+.
    #
    #   assert_false(false)
    #
    def assert_false(exp, msg=nil)
      FalseAssay.assert!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +false+.
    #
    #   assert_not_false(false)
    #
    def assert_not_false(exp, msg=nil)
      FalseAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are equal within `delta` absolte tolerance.
    #
    #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def assert_in_delta(exp, act, delta, msg=nil)
      WithinAssay.assert!(act, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are NOT equal within `delta` absolute tolerance.
    #
    #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def assert_not_in_delta(exp, act, delta, msg=nil)
      WithinAssay.refute!(act, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `exp` and `act` are within `epsilon` relative tolerance.
    #
    def assert_in_epsilon(exp, act, epsilon=0.001, message=nil)
      exp = epsilon if exp.zero?  # why does minitest do this?
      CloseAssay.assert!(act, exp, epsilon, :message=>message, :backtrace=>caller)
    end

    #
    # Passes if `exp` and `act` are NOT within `epsilon` relative tolerance.
    #
    def assert_not_in_epsilon(exp, act, epsilon=0.001, message=nil) 
      exp = epsilon if exp.zero?
      CloseAssay.refute!(act, exp, epsilon, :message=>message, :backtrace=>caller)
    end

    #
    # Passes if `collection` contains `member`.
    #
    def assert_includes(collection, member, message=nil) 
      IncludeAssay.assert!(collection, member, :message=>message, :backtrace=>caller)
    end

    #
    # Passes if `collection` does not contain `member`.
    #
    def assert_not_includes(collection, member, message=nil)
      IncludeAssay.refute!(collection, member, :message=>message, :backtrace=>caller) 
    end

    #
    # Passes if object is an instance of class.
    #
    #   assert_instance_of(String, 'foo')
    #
    def assert_instance_of(cls, obj, msg=nil)
      InstanceAssay.assert!(obj, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not an instance of class.
    #
    #   assert_not_instance_of(String, 500)
    #
    def assert_not_instance_of(cls, obj, msg=nil)
      InstanceAssay.refute!(obj, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object .kind_of? klass
    #
    #   assert_kind_of(Object, 'foo')
    #
    def assert_kind_of(cls, obj, msg=nil)
      KindAssay.assert!(obj, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object .kind_of? klass
    #
    #   assert_not_kind_of(Object, 'foo')
    #
    def assert_not_kind_of(cls, obj, msg=nil)
      KindAssay.refute!(obj, cls, :message=>msg, :backtrace=>caller)
    end

    # Passes if object matches pattern using `#=~` method.
    #
    #   assert_match(/\d+/, 'five, 6, seven')
    #
    def assert_match(pattern, string, msg=nil)
      MatchAssay.assert!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    # Passes if object does not match pattern using `#=~` method.
    #
    #   assert_no_match(/two/, 'one 2 three')
    #
    def assert_not_match(pattern, string, msg=nil)
      MatchAssay.refute!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    # Passes if object has no match pattern using `#!~` method.
    #
    #   assert_no_match(/two/, 'one 2 three')
    #
    def assert_no_match(pattern, string, msg=nil)
      NoMatchAssay.assert!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    ## Passes if object has a match pattern using `#!~` method.
    ##
    ##   assert_not_no_match(/two/, 'one two three')
    ##
    #def assert_not_no_match(pattern, string, msg=nil)
    #  NoMatchAssay.refute!(string, pattern, :message=>msg, :backtrace=>caller)
    #end

    # Passed if object is +nil+.
    #
    #   assert_nil(nil)
    #
    def assert_nil(exp, msg=nil)
      NilAssay.assert!(exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +nil+.
    #
    #   assert_not_nil(true)
    #
    def assert_not_nil(exp, msg=nil)
      NilAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    #
    #
    def assert_predicate(object, predicate, message = nil) 
      ExecutionAssay.assert!(:message=>message) do
        object.__send__(predicate)
      end
    end

    #
    #
    #
    def assert_not_predicate(object, predicate, message = nil) 
      ExecutionAssay.refute!(:message=>message) do
        object.__send__(predicate)
      end
    end

    #
    # Passes if +object+ respond_to? +methods+.
    #
    #   assert_respond_to 'bugbear', :slice
    #
    def assert_respond_to(reciever, method, msg=nil)
      RespondAssay.assert!(reciever, method, :message=>msg, :backtrace=>caller)
    end
    alias_method :assert_responds_to, :assert_respond_to

    #
    # Passes if +object+ does not respond_to? +methods+.
    #
    #   assert_not_respond_to 'bugbear', :slice
    #
    def assert_not_respond_to(reciever, method, msg=nil)
      RespondAssay.refute!(reciever, method, :message=>msg, :backtrace=>caller)
    end

    # Passes if +expected+ .eql? +actual+.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   assert_equivalent 'MY STRING', 'my string'.upcase
    #
    def assert_equivalent(exp, act, msg=nil)
      EqualityAssay.assert!(act, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if +criterion+ is NOT equivalent to +actual+ as tested using `#eql?`.
    #
    #  assert_not_equivalent 1, 1.0
    #
    def assert_not_equivalent(criterion, act, msg=nil)
      EqualityAssay.refute!(act, criterion, :message=>msg, :backtrace=>caller)
    end

    #
    #
    # TODO: Is this supposed to be restricted in some way?
    def assert_operator(receiver, operator, operand, message=nil) 
      ExecutionAssay.assert!(:message=>message, :backtrace=>caller) do
        receiver.__send__(operator, operand)
      end
    end

    #
    #
    #
    def assert_path_exist(path, message=nil)
      PathAssay.assert!(path, :message=>message, :backtrace=>caller)
    end

    #
    #
    #
    def assert_path_not_exist(path, message=nil) 
      PathAssay.refute!(path, :message=>message, :backtrace=>caller)
    end

    #
    # Passes if the block raises a given exception.
    #
    #   assert_raise RuntimeError do
    #     raise 'Boom!!!'
    #   end
    #
    def assert_raise(exception, message=nil, &block)
      RaiseAssay.assert!(exception, :message=>message, :backtrace=>caller, &block)
    end

    alias_method :assert_raises, :assert_raise

    #
    # Passes if the block *does not* raise a given exceptions.
    #
    #   assert_not_raised IOError do
    #     raise 'Boom!!!'
    #   end
    #
    def assert_not_raised(exception, message=nil, &block) #:yeild:
      RaiseAssay.refute!(exception, :message=>message, :backtrace=>caller, &block)
    end

    #
    # Passes if the block yields successfully.
    #
    #   assert_nothing_raised "Couldn't do the thing" do
    #     do_the_thing
    #   end
    #
    def assert_nothing_raised(message=nil, &block)
      RescueAssay.refute!(Exception, :message=>message, :backtrace=>caller, &block)
    end

    #
    # Passes if the block raises a given exception.
    #
    #   assert_raise_kind_of RuntimeError do
    #     raise 'Boom!!!'
    #   end
    #
    def assert_raise_kind_of(exception_class, message=nil, &block)
      RescueAssay.assert!(exception_class, :message=>message, :backtrace=>caller, &block)
    end

    #
    #def assert_raise_message(*args, &block) 
    #end

    #
    # Passes if actual is the same exact object as expected.
    #
    #   assert_same(object, object)
    #
    def assert_same(exp, act, msg=nil)
      IdentityAssay.assert!(act, exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if actual is not the same exact object as expected.
    #
    #   assert_not_same(object, other)
    #
    def assert_not_same(exp, act, msg=nil)
      IdentityAssay.refute!(act, exp, :message=>msg, :backtrace=>caller)
    end

    #
    #
    #
    #def assert_send(send_array, message=nil)
    #end

    #
    # Passes if the block throws `expected` object.
    #
    #   assert_throw :done do
    #     throw :done
    #   end
    #
    def assert_throw(expected, msg=nil, &blk)
      ThrowAssay.assert!(expected, :message=>msg, :backtrace=>caller, &blk)
    end

    alias_method :assert_throws, :assert_throw

    #
    # Passes if the block does not throws `expected` object.
    #
    #   assert_not_thrown :done do
    #     throw :chimp
    #   end
    #
    def assert_not_thrown(expected, msg=nil, &blk)
      ThrowAssay.refute!(expected, :message=>msg, :backtrace=>caller, &blk)
    end

    #
    #
    #
    def assert_nothing_thrown(message=nil, &blk)
      ThrowAssay.refute!(nil, :message=>message, &blk)
    end

    #
    # Passed if object is +true+.
    #
    def assert_true(exp, msg=nil)
      TrueAssay.assert!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +true+.
    #
    #   assert_not_true(false)
    #
    def assert_not_true(exp, msg=nil)
      TrueAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

  end

end
