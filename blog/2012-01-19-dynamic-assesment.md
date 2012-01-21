= Dynamic Assesment

Assay was originally conceived of as a set of assertion classes that
reflected the design of Ruby's own exception system. Since assertion
frameworks work by rescuing a specially raised error, e.g. ... in
Test:Unit, ..Failure in RSpec and `Assertion` in MiniTest, it seems logical
that subclasses of such a class could be defined to represent specific
assertions. And that these classes could act as both the error thrown
and as the encapsulators of the logic for testing the assertion.
So that's how Assay was implemented and it works well.
However, there is a significant limitation with this design. 

Having a finite set of assertion classes greatly limits the types of
assertions supported by derivative notations. Consider the case
of Ruby Facets `String#upcase?` method. How could that method be applied
as an assertion? We certainly are not going to create a new assay class
for each and every little queriable method such as this --though certainly
we could if it were reused enough. So we are left in the rare and unique
case to fallback to indirect forms. In TestUnit assertion notation:

  assert string.upcase?

Or RSpec's notation:

  string.upcase?.should be_true

In effect, we have bypassed what the assertion is really about and just
sought assertion on the final true/false result. This isn't ideal. However,
this is a limitation of all assertion frameworks in existence, with
the sole exception of AE. So while, it might be nice to think we should 
be able to do:

  string.should be_upcase

That's simply not realistic with a limited set of assertion definitions.
Rather, it would have to be a dynamic system. But a fully dynamic system
comes with it's own downsides. Error messages can't be customized to the
assertions and assertions would not correspond to specific Error classes.

It's a sucky trade-off, and the only cure possible is a compromise. On the 
one hand have a specially defined set of assertions and on the
other support dynamic fallbacks.

