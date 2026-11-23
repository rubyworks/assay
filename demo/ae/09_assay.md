# Assay Classes

The AE notation asserts the result of whatever method is called on the
object under test. Assay adds two things to that.

## Typed Failures

When the method is the operator of an Assay class, a failure is raised
as that class. The object's own method still decides the result.

    expect KindAssay do
      10.assert.kind_of?(String)
    end

    expect NilAssay do
      10.assert.nil?
    end

    expect IncludeAssay do
      [1,2,3].assert.include?(4)
    end

    expect LessAssay do
      10.assert < 5
    end

    expect UnequalAssay do
      10.assert != 10
    end

So too when it is negated.

    expect KindAssay do
      10.refute.kind_of?(Integer)
    end

AE's own query methods have classes as well: `eq?` fails with an
EqualAssay, `case?` with a CaseAssay, `equal?` with an IdentityAssay,
`in_delta?` with a WithinAssay, `in_epsilon?` with a CloseAssay,
`raised?` and `raises?` with a RescueAssay, `thrown?` and `throws?`
with a ThrowAssay.

    expect WithinAssay do
      3.assert.in_delta?(10, 1)
    end

    expect RescueAssay do
      ArgumentError.assert.raised?{ :fine }
    end

    expect IdentityAssay do
      "abc".assert.equal?("abc".dup)
    end

Since every Assay class is an Assertion, code that rescues Assertion
is none the wiser.

    expect Assertion do
      10.assert.kind_of?(String)
    end

A method Assay has no class for fails with a plain Assertion.

    error = begin
      10.assert.odd? ; nil
    rescue Assertion => e
      e
    end

    error.class.assert == Assertion

    10.refute.odd?

    error = begin
      10.refute.even? ; nil
    rescue Assertion => e
      e
    end

    error.class.assert == Assertion

## Assay's Own Words

If the object has no method by the name, but Assay has an assertion by
that operator or name, the Assay class makes the test.

    "abc".assert.like?("abc")

    10.assert.kind_of(Integer)

    10.assert.within?(11, 2)

    expect KindAssay do
      10.assert.kind_of(String)
    end

    expect WithinAssay do
      10.assert.within?(20, 2)
    end

Anything else is an error, not an assertion.

    expect NoMethodError do
      10.assert.zork
    end

## Assay Matchers

An Assay class can be turned into a matcher with `[]`, and `assert`
and `refute` accept one.

    is_ten = EqualAssay[10]

    10.assert is_ten
    11.refute is_ten

    expect EqualAssay do
      11.assert is_ten
    end

    expect EqualAssay do
      10.refute is_ten
    end

