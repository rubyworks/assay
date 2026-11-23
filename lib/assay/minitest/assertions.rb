module Assay; end
module Assay::MiniTest

  # This module holds the MiniTest assertion methods for MiniTest
  # compatibility.
  #
  # While it does not provide 100% of MiniTest's assertions at the moment,
  # compatibility is very close and will improved with upcoming releases.
  #
  # TODO: Should we adjust error messages to be like MiniTests ?
  #
  module Assertions

    #
    def assert(truth, msg=nil)
      Assertion.assert!(truth, :message=>msg)
    end

    #
    def refute(untruth, msg=nil)
      Assertion.refute!(untruth, :message=>msg)
    end

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
    def refute_alike(exp, act, msg=nil)
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
    # Passes if `boolean` is neither `true` or `false`.
    #
    def refute_boolean(boolean, message=nil)
      BooleanAssay.refute!(boolean, :message=>message)
    end

    #
    #def assert_const_defined(object, constant_name, message = nil)
    #end
    #
    #def refute_const_defined(object, constant_name, message = nil)
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
    def refute_empty(exp, msg=nil)
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
    #  refute_equal 'some string', 5
    #
    def refute_equal(exp, act, msg=nil)
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
    #   refute_false(false)
    #
    def refute_false(exp, msg=nil)
      FalseAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are equal within absolute delta.
    #
    #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def assert_in_delta(exp, act, delta, msg=nil)
      WithinAssay.assert!(act, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are NOT equal within absolute delta.
    #
    #   refute_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    def refute_in_delta(exp, act, delta, msg=nil)
      WithinAssay.refute!(act, exp, delta, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are equal within relative `epsilon`.
    #
    def assert_in_epsilon(exp, act, epsilon=0.001, message=nil) 
      #delta = [exp, act].min * epsilon
      CloseAssay.assert!(act, exp, epsilon, :message=>message, :backtrace=>caller)
    end

    #
    # Passes if expected and actual are NOT equal within relative `epsilon`.
    #
    def refute_in_epsilon(exp, act, epsilon=0.001, message=nil)
      #delta = [exp, act].min * epsilon
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
    def refute_includes(collection, member, message=nil)
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
    #   refute_instance_of(String, 500)
    #
    def refute_instance_of(cls, obj, msg=nil)
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
    #   refute_kind_of(Object, 'foo')
    #
    def refute_kind_of(cls, obj, msg=nil)
      KindAssay.refute!(obj, cls, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object matches pattern using `#=~` method.
    #
    #   assert_match(/\d+/, 'five, 6, seven')
    #
    def assert_match(pattern, string, msg=nil)
      MatchAssay.assert!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object does not match pattern using `#=~` method.
    #
    #   assert_no_match(/two/, 'one 2 three')
    #
    def refute_match(pattern, string, msg=nil)
      MatchAssay.refute!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object does not match pattern using `#!~` method.
    #
    #   assert_no_match(/two/, 'one 2 three')
    #
    def assert_no_match(pattern, string, msg=nil)
      NoMatchAssay.assert!(string, pattern, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is +nil+.
    #
    #   assert_nil(nil)
    #
    def assert_nil(exp, msg=nil)
      NilAssay.assert!(exp, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if object is not +nil+.
    #
    #   refute_nil(true)
    #
    def refute_nil(exp, msg=nil)
      NilAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

    # 
    # Passes if a block outputs matching test to `stdout` or `staderr`.
    #
    # This does not work _exactly_ like the original MiniTest assertion in
    # that it is an *and* condition between the two stdout and stderr, whereas
    # the original is and *or* condition.
    #
    # Note that this assertion translates into two separate underlying assertions,
    # so counts for it may be double of what one might expect.
    #
    def assert_output(stdout=nil, stderr=nil, &block)
      StdoutAssay.assert!(stdout, :backtrace=>caller, &block) if stdout
      StderrAssay.assert!(stderr, :backtrace=>caller, &block) if stderr
    end

    #
    # Passes if a block outputs matching test to `stdout` or `staderr`.
    #
    # This does not work _exactly_ like the original MiniTest assertion in
    # that it is an *and* condition between the two stdout and stderr, whereas
    # the original is and *or* condition.
    #
    # Note that this assertion translates into two separate underlying assertions,
    # so counts for it may be double of what one might expect.
    #
    def refute_output(stdout=nil, stderr=nil, &block)
      StdoutAssay.refute!(stdout, :backtrace=>caller, &block) if stdout
      StderrAssay.refute!(stderr, :backtrace=>caller, &block) if stderr
    end

    #
    # Like {#assert_output} but ensures no output.
    #
    def assert_silent(msg=nil, &block)
      SilentAssay.assert!(:message=>msg, :backtrace=>caller, &block)
    end

    #
    # Like {#refute_output} but ensures some output.
    #
    def refute_silent(msg=nil, &block)
      SilentAssay.refute!(:message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passes it +predicate+ sent to object returns postively.
    #
    #   assert_predicate(10, :even?)
    #
    def assert_predicate(object, predicate, message=nil) 
      ExecutionAssay.assert!(:message=>message, :backtrace=>caller) do
        object.__send__(predicate)
      end
    end

    #
    # Passes it +predicate+ sent to object returns negatively.
    #
    #   refute_predicate(10, :odd?)
    #
    def refute_predicate(object, predicate, message=nil) 
      ExecutionAssay.refute!(:message=>message, :backtrace=>caller) do
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
    #   refute_respond_to 'bugbear', :slice
    #
    def refute_respond_to(reciever, method, msg=nil)
      RespondAssay.refute!(reciever, method, :message=>msg, :backtrace=>caller)
    end

    #
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

    #
    # Passes if +criterion+ is NOT equivalent to +actual+ as tested using `#eql?`.
    #
    #  refute_equivalent 'some string', 5
    #
    def refute_equivalent(criterion, act, msg=nil)
      EqualityAssay.refute!(act, criterion, :message=>msg, :backtrace=>caller)
    end

    #
    #
    #
    def assert_operator(receiver, operator, operand, message=nil) 
      ExecutionAssay.assert!(:message=>message, :backtrace=>caller) do
        receiver.__send__(operator, operand)
      end
    end

    #
    #
    #
    def refute_operator(receiver, operator, operand, message=nil) 
      ExecutionAssay.refute!(:message=>message, :backtrace=>caller) do
        receiver.__send__(operator, operand)
      end
    end

    #
    # Passes if the block raises given exception(s).
    #
    #   assert_raises RuntimeError do
    #     raise 'Boom!!!'
    #   end
    #
    def assert_raises(*exceptions, &block)
      msg = (Exception === exceptions.last ? exceptions.pop : nil)
      RaiseAssay.assert!(*exceptions, :message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passes if the block *does not* raise given exception(s).
    #
    #   refute_raises RuntimeError do
    #     raise 'Boom!!!'
    #   end
    #
    def refute_raises(*exceptions, &block)
      msg = (Exception === exceptions.last ? exceptions.pop : nil)
      RaiseAssay.refute!(*exceptions, :message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passes if the block yields successfully.
    #
    #   refute_nothing_raised "Couldn't do the thing" do
    #     do_the_thing
    #   end
    #
    def assert_nothing_raised(msg=nil, &block)
      RescueAssay.refute!(Exception, :message=>msg, :backtrace=>caller, &block)
    end

    #
    # Passes if the block yields successfully.
    #
    #   refute_nothing_raised "Couldn't do the thing" do
    #     do_the_thing
    #   end
    #
    def refute_nothing_raised(msg=nil, &block)
      RescueAssay.assert!(Exception, :message=>msg, :backtrace=>caller, &block)
    end

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
    #   refute_same(object, other)
    #
    def refute_same(exp, act, msg=nil)
      IdentityAssay.refute!(act, exp, :message=>msg, :backtrace=>caller)
    end

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
    def assert_throws(expected, msg=nil, &blk)
      ThrowAssay.assert!(expected, :message=>msg, :backtrace=>caller, &blk)
    end

    #
    # Passes if the block does not throws `expected` object.
    #
    #   refute_throws :done do
    #     throw :chimp
    #   end
    #
    def refute_throws(expected, msg=nil, &blk)
      ThrowAssay.refute!(expected, :message=>msg, :backtrace=>caller, &blk)
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
    #   refute_true(false)
    #
    def refute_true(exp, msg=nil)
      TrueAssay.refute!(exp, :message=>msg, :backtrace=>caller)
    end

  end

end
