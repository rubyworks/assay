# Asay Lookup

Assay classes are indexed by both name and associated operation, so they
can be looked-up by either. The indexes are stored as class attributes of
the Assertion base class.

Let's lookup the class for `==` equality.

  Assertion.by_operator(:==)      #=> ::EqualAssay

Let's lookup the assertion class for `#empty?`.

  Assertion.by_operator(:empty?)  #=> ::EmptyAssay

If we wish to lookup by assertive name instead of operator, we can use
the `by_name` method instead.

  Assertion.by_name(:empty)       #=> ::EmptyAssay

We can also use the `Assay.lookup` module method, which will lookup an assay
class by either assertion name or associated operator.

  Assay.lookup(:==)               #=> ::EqualAssay
  Assay.lookup(:empty?)           #=> ::EmptyAssay

