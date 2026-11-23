# Assay

[Documentation](https://rubydoc.info/gems/assay) /
[Report Issue](https://github.com/rubyworks/assay/issues) /
[Source Code](https://github.com/rubyworks/assay)

[![Gem Version](https://badge.fury.io/rb/assay.svg)](https://badge.fury.io/rb/assay)
[![CI](https://github.com/rubyworks/assay/actions/workflows/ci.yml/badge.svg)](https://github.com/rubyworks/assay/actions/workflows/ci.yml)


## DESCRIPTION

Assay defines assertions in the same way that Ruby defines
exceptions. Each kind of assertion is a class: it knows how to test,
how to explain a failure, and it is the exception raised when the
assertion fails. Assay provides a complete set of these classes for
the common kinds of assertion.

On top of the classes Assay provides a choice of notations for writing
assertions, each loaded on its own:

| Require | Notation |
|---|---|
| `assay/minitest` | Minitest's `assert_equal` and `must_equal` |
| `assay/testunit` | Test::Unit's `assert_equal` |
| `assay/rspec` | RSpec's `should eq` and `expect(x).to eq` |
| `assay/fluidity` | Assay's own: `x.should.equal y`, `x.assert == y` |
| `assay/ae` | AE's functor: `x.assert == y`, `a.assert.include?(e)` |
| `assay/bang` | Query methods as assertions: `x.equal!(y)`, `x.empty!` |

Whichever you choose, a failure is an instance of the same assay class,
and any test framework that follows the
[BRASS](https://github.com/rubyworks/brass) standard counts it as a
failed assertion.


## FEATURES

* Patterned after the Ruby exception system.
* A failed assertion has a type, and an error message to suit it.
* Supports any variety of assertion notation.
* Can be used with almost any test framework.


## INSTALLATION

    $ gem install assay

Assay needs Ruby 2.7 or newer.


## UTILIZATION

### Assay Classes

Assay consists of a set of Assertion subclasses known as *assays*. They
are akin to Ruby's Exception subclasses, indeed the `Assertion` base class
is a subclass of Exception. But assays have special class methods that are
used to make assertions.

Consider the `EqualAssay` class. It defines methods for asserting equality
via the `#==` method.

    EqualAssay.assert!(1,1)

Additionally, we can check the assertion's test without actually raising the
assertion if it fails using the query method.

    EqualAssay.pass?(1,1)    #=> true

Assays also provide the opposite method `#refute!` along with `#fail?`.

    EqualAssay.refute!(1,2)

    EqualAssay.fail?(1,2)    #=> true

Assay instances are test matchers, which can be conveniently defined with `#[]`.

    EqualAssay[1] =~ 1

Notice in the example we have used `#=~` to apply the matcher which makes
the `#assert!` call to the Assay object. Likewise `#!~` can be used to
call `#refute!` instead. And note that `#===` is also an alias for `#=~`.

    EqualAssay[1] === 1

Which means assay matchers can be used in case statements.

    case 10
    when InstanceAssay[Integer]
    when EqualAssay[10.0]
    end

Pretty neat.

### Notations

The classes make a sound foundation, but in the end we want to write
assertions easily and concisely. Each notation is a thin layer over the
assay classes, and is loaded only when asked for.

#### Fluidity

Assay's own notation reads as a chain of words off the object under test.

    require 'assay/fluidity'

    10.should.be.kind_of(Integer)
    10.should_not.equal(20)

If you are accustomed to Minitest's spec methods, you might prefer `must`.

    10.must.be.kind_of(Integer)

And to satisfy the technical aficionados there is `assert`.

    10.assert.kind_of(Integer)
    10.assert == 10

`assay/fluidity` loads `should`, `must` and `assert`. Each can be loaded
alone (`assay/fluidity/should`), and `is` and `will` are available the
same way (`assay/fluidity/is`, `assay/fluidity/will`).

#### AE

The AE notation, from the [AE](https://github.com/rubyworks/ae) gem,
needs no vocabulary of its own: call any method of the object under
test through `assert`, and its result is asserted.

    require 'assay/ae'

    x.assert == y
    a.assert.include?(e)
    x.refute.nil?
    "Daffy Duck".assert.start_with?("Daffy")

Where Assay has a class for the method, as it does for the first three,
that class is the failure raised; otherwise it is a plain `Assertion`.
`assert` still takes a truth value, or a block, as it does in Test::Unit.

    assert(x > 3, "too small")
    assert{ x > 3 }

`expect` tests a block's result by case equality, or that it raises.

    expect ArgumentError do
      Integer("x")
    end

The subjunctive verbs and the `ok`/`no` checks are loaded separately.

    require 'assay/ae/should'   # x.should == y, x.should.be.a String
    require 'assay/ae/must'     # x.must == y
    require 'assay/ae/check'    # check{ |a, b| a == b }; ok 1, 1

AE and Fluidity both define `assert`, `should` and `must` on every
object, so load one or the other. Likewise load `assay/ae` or the AE
gem, not both: the gem stands on its own and raises only `Assertion`.

#### Bang

Bang turns a query method into an assertion: call it with `!` in place
of `?`, and prefix `not_` to negate it.

    require 'assay/bang'

    10.kind_of!(Integer)
    10.equal!(5 + 5)
    10.not_equal!(20)

Where Assay has a class for the assertion, as it does for these, that
class is the failure raised. Any other query method an object has works
too, and fails with a plain `Assertion`.

    10.even!
    10.between!(1, 20)

For a procedure there are `raises!`, `rescues!` and `throws!`.

    lambda{ raise ArgumentError }.raises!(ArgumentError)

#### RSpec

    require 'assay/rspec'

    include Assay::Matchers

    10.should be_kind_of(Integer)

    expect(10).to eq(10)
    expect{ raise ArgumentError }.to raise_error(ArgumentError)

#### Minitest

    require 'assay/minitest'

    include Assay::Assertions

    assert_equal 10, 5 + 5
    assert_kind_of Integer, 10

    10.must_equal 5 + 5

#### Test::Unit

    require 'assay/testunit'

    include Assay::Assertions

    assert_equal 10, 5 + 5
    assert_not_equal 10, 6 + 5

The three compatibility notations make it possible to move tests to
another framework without rewriting their assertions. They cover the
commonly used parts of each framework's API, not all of it.

These are just a few possible notations. There is no reason not to build
your own on top of Assay's classes if you have another approach in mind.
That, after all, is the purpose of having a set of reusable assertion
classes. Assay classes can be looked up by operator or by name, which
makes this easy:

    Assay.lookup(:==)       #=> EqualAssay
    Assay.lookup(:empty?)   #=> EmptyAssay

### Framework Adapters

Assay follows the BRASS standard: its assertion classes have an
`#assertion?` method that returns `true`, by which a test framework can
tell a failed assertion from an ordinary error.
[Rubytest](https://github.com/rubyworks/rubytest) and the frameworks
built on it do this already. For Minitest and Test::Unit, which don't,
Assay provides adapters. Add one to your test helper:

    require 'assay/adapter/minitest'

or

    require 'assay/adapter/testunit'

Without the adapter you can still use Assay with these frameworks. They
will count Assay's failed assertions as errors rather than failures.

RSpec has no adapter. It reports any exception raised in an example as
a failure of that example, so Assay works in it as is.

### Upgrading from 0.4

Since version 0.5 the notations are part of Assay again. The separate
gems are retired:

| Before | Now |
|---|---|
| gem `fluidity`, `require 'fluidity'` | `require 'assay/fluidity'` |
| gem `rspecial`, `require 'rspecial'` | `require 'assay/rspec'` |
| gem `assay-minitest` | `require 'assay/minitest'` |
| gem `assay-testunit` | `require 'assay/testunit'` |
| gem `bang`, `require 'bang'` | `require 'assay/bang'` |

`Fluidity` is now `Assay::Fluidity`, and `RSpecial` is `Assay::RSpec`.
Bang's failures are now assay classes where there is one, not
`Bang::Assertion`, and the query methods it added to Object (such as
`equal_to?` and `raises?`) are gone.
`Assay::Assertions`, `Assay::Matchers` and `Assay::Extensions` are as
they were.

The AE gem is not retired. `assay/ae` is the same notation built on
Assay's classes, under `Assay::AE` rather than `AE`. It leaves out
`ae/legacy` (use `assay/testunit`), `ae/pry` and AE's framework
adapters (Assay has its own, above).

### Learning More

There is more to learn about Assay, mainly the variety of assay classes
available. The [demos](https://github.com/rubyworks/assay/tree/master/demo)
give an overview with working examples: they are run as tests with
[QED](https://github.com/rubyworks/qed). The
[API documentation](https://rubydoc.info/gems/assay) has the rest.


## LICENSE & COPYRIGHT

Copyright (c) 2010 Rubyworks

This program is distributed under the terms of the *BSD-2-Clause* license.

See LICENSE.txt file for details.
