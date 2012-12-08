# Assay

[Website](http://rubyworks.github.com/assay) /
[Report Issue](http://github.com/rubyworks/assay/issues) /
[Source Code](http://github.com/rubyworks/assay) /
[Mailing List](http://groups.google.com/group/rubyworks-mailinglist)


## DESCRIPTION

Assay defines assertions in the same way that Ruby defines
exceptions. An assertion then is nothing more that an
extended Exception class. Assay provides a complete set
of these assertion classes for the most common assertion types.
It also provides both TestUnit-style assertion methods and
RSpec-compatiable matchers built from these assertion classes
for use in your preferred test harness. Assay is compatible with
TestUnit, MiniTest, RSpec and other test frameworks.


## FEATURES

* Patterned after the Ruby exception system.
* Allows assertions specialized error messages.
* Supports any variety of assertion "grammers".
* Can be used with almost any test framework. 


## LIMITATIONS

* Assay is Ruby 1.9+ only!


## INSTALLATION

To install with RubyGems simply open a console and type:

    $ gem install assay

Site installation with the tarball can be done with Ruby Setup
(gem install setup). See http://rubyworks.github.com/setup.


## UTILIZATION

### Assay Classes

Assay consists of a set of Assertion subclasses known as *assays*. They
are akin to Ruby's Exception subclasses, indeed the +Assertion+ base class
is a subclass of Exception. But assays have special class methods that are
used to make assertions.

Consider the +EqualityAssay+ class. It defines methods for asserting equality
via the `#==` method.

    EqualityAssay.assert!(1,1)

Additionally, we can check the assertion's test without actually raising the
assertion if it fails using the query method.

    EqualityAssay.pass?(1,1)    #=> true

Assays also provide the opposite method `#refute!` along with `#fail?`.

    EqualityAssay.refute!(1,2)

    EqualityAssay.fail?(1,2)    #=> true

Assay instances are test matchers, which can be conveniently defined with `#[]`.

    EqualityAssay[1] =~ 1

Notice in the example we have used `#=~` to apply the matcher which makes
the `#assert!` call to the Assay object. Likewise `#!~` can be used to
call `#refute!` instead. And note that `#===` is also an alias for `#=~`.

    EqualityAssay[1] === 1

Which means assay matchers can be used in case statments.

    case 10
    when InstanceAssay[Fixnum]
    when EqualityAssay[10.0]
    end

Pretty neat.

### Framework Adapters

Assay follows a standard practice of defining assertion error classes with
an `#assertion?` method that returns +true+. This can be used by any test 
framework to easily detect when a raised error is an assertion rather than
an ordinary error. To add support for this to common test frameworks Assay
provides adapters.

For example, to use assay with MiniTest framework add to your test helper
script:

    require 'assay/adapter/minitest'

Likewise for TestUnit.

    require 'assay/adapter/testunit'

An RSpec adadpter is in the works, and should be out with the next release.

Note that even without the adapter, you can still use Assay with other test
frameworks. They will simply count Assay's assertions as regular errors.

### Customized Grammars

Of course the classes are interesting and clearly make for a sound foundation,
but in the end we want to write assertions more easily and concisely. For this
we turn to separate "grammar" projects that depend on Assay's classes. The
first of these, created as a spin-off project to demonstrate Assay's prowess,
is {Fluidity}[http://rubyworks.github.com/fluidity]. Here is a quick taste of
that gem's functionality.

    require 'fluidity'

    10.should.be.kind_of(Integer)

But is you are acustom to MiniTest's spec methods, you might prefer `must`.

    10.must.be.kind_of(Integer)

And to satisfy all those technical aficionados (like yours truly) there is `assert`.

    10.assert.kind_of(Integer)

Thre are also compatibility grammar projects available, spun-off from Assay, that
provide compatability with legacy test frameworks which can serve as transition
to Assay from these other frameworks. Follow the links below for each:

* {Assay TestUnit}[http://github.com/rubyworks/assay-testunit]
* {Assay MiniTest}[http://github.com/rubyworks/assay-minitest]
* {Assay RSpec}[http://github.com/rubyworks/assay-rspec]

Usage is essentially the same for any one of them. For example,

    require 'assay/rspec'

    include Assay::Matchers

    10.should be_kind_of(Integer)

Note that the compatibility modules are not yet 100% compatable, lacking some
of the more esoteric and complex features. But they are very nearly so, and
will become more so in time.

These are just a few possible grammars. There is no reason not to build
your own grammar on top of Assay's classes if you have another approach in mind.
Indeed, please do! That, after all, is the main purpose of having such
a set of reusable assertion classes!

### Learning More

There's more learn about Assay, mainly the variety of assay classes available,
but also a few other bits of functionality not comvered here. To learn
about these check out the {QED documentation}[http://github.com/rubyworks/assay]
which provides an overiew of functionality with working examples, and the
the {API documentation}[http://rubydoc.info/gems/asasy] for a more in depth look
under the hood.


## LICENSE & COPYRIGHT

Copyright (c) 2009 Rubyworks

This program is ditributed under the terms of the *BSD-2-Cluase* license.

See LICENSE.txtfile for details.

