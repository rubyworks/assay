# The AE Notation

AE (Assertive Expressive) is a notation designed around the concept of
an Assertor. The Assertor is an Assertion Functor, or Higher-Order
Function, which reroutes method calls while monitoring them for failing
conditions. It began as a library of its own, the AE gem, and is here
built on Assay's assertion classes.


## What It Provides

Requiring the notation

    require 'assay/ae'

loads the +Assertor+ class, the method +assert+ and its antonyms
+assert!+ and +refute+, the method +expect+, and a set of core
extensions that make writing certain types of assertions easier.


## Assertion and Assertor Classes

The +Assertion+ class is at the heart of it. The +Assertion+ class
is a subclass of Exception. When an assertion is made and fails, it
is an Assertion that is raised: either an instance of Assertion
itself, or of the Assay class for the method used, each of which is
a subclass of Assertion.

    expect Assertion do
      msg = "my failure message"
      assert false, msg
    end

Like any raised exception, the last Assertion message is available
via `$!`.

(FYI, in Test::Unit the equivalent class was called +AssertionFailedError+.)

Assertions themselves are not generally used in creating tests or
behavior specifications. Rather they are used to create additional
types of assertion methods.

As mentioned above the +Assertor+ class is a type of Higher-Order
function, or Functor, which intercedes with a normal message
invocation to monitor for failed conditions, upon which is raises
Assertion exceptions.


## Assertion Methods

The three methods, +assert+, <tt>assert!</tt> and +refute+ all
return an Assertor instance when used fluidly, i.e. magic-dot
notation, higher-order notation, functor notation, whatever you
prefer to call it.

    assert(Assay::AE::Assertor === assert)

Through the use of +method_missing+, the Assertor allows us to write
statements like:

    1.assert == 1

If the operation evaluates to false or nil, then an Assertion error
is raised.

    expect Assertion do
      1.assert == 2
    end

Assay has a class for `==`, so more exactly it is an EqualAssay.

    expect EqualAssay do
      1.assert == 2
    end

The methods <tt>assert!</tt> and +refute+ are just like +assert+
expect they purport the negative condition. Patterned after Ruby's
own use of "<tt>!</tt>" as meaning +not+, <tt>assert!</tt> should be
read "assert not". While +refute+ exists for the sake of those who
find the use of a bang method for this purpose unsuited to them.


## How It Works

An Assertor essentially sits in wait for a method call (via
method_missing). When that happens it applies the method to the
original receiver, but wrapped in a clause that raises an
Assertion should the statement fail. If we wanted to be 
pedantic, we could write our assertions like:

    raise Assertion.new("1 != 1") unless 1 == 1

Instead of 

    1.assert == 1

Obviously using Assertor methods are whole lot more concise.

